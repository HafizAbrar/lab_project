import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../roles/presentation/providers/roles_providers.dart';
import '../../data/models/create_user_dto.dart';
import '../providers/users_providers.dart';


class UserFormPage extends ConsumerStatefulWidget {
  const UserFormPage({super.key});

  @override
  ConsumerState<UserFormPage> createState() => _UserFormPageState();
}

class _UserFormPageState extends ConsumerState<UserFormPage> {
  final _form = GlobalKey<FormState>();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final nameCtrl = TextEditingController();

  String? _selectedRoleId; // 👈 track selected role

  @override
  Widget build(BuildContext context) {
    final createState = ref.watch(createUserControllerProvider);
    final rolesAsync = ref.watch(rolesListProvider); // 👈 fetch roles list

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              TextFormField(
                controller: nameCtrl,
                decoration: const InputDecoration(labelText: 'Full name'),
                validator: (v) =>
                (v == null || v.trim().length < 2)
                    ? 'Enter at least 2 characters'
                    : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: emailCtrl,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (v) =>
                (v == null || !v.contains('@'))
                    ? 'Invalid email'
                    : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: passCtrl,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (v) =>
                (v == null || v.length < 8) ? 'Min 8 chars' : null,
              ),
              const SizedBox(height: 16),

              // --- Role dropdown ---
              rolesAsync.when(
                data: (roles) {
                  return DropdownButtonFormField<String>(
                    value: _selectedRoleId,
                    decoration: const InputDecoration(labelText: 'Role'),
                    items: roles
                        .map(
                          (role) => DropdownMenuItem(
                        value: role.id, // 👈 assuming role has `id`
                        child: Text(role.name),
                      ),
                    )
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedRoleId = value;
                      });
                    },
                    validator: (value) =>
                    value == null ? 'Please select a role' : null,
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Text("Failed to load roles: $e"),
              ),

              const SizedBox(height: 16),

              // Show error if any
              if (createState is AsyncError)
                Text(
                  createState.error.toString(),
                  style: const TextStyle(color: Colors.red),
                ),

              const SizedBox(height: 8),

              FilledButton(
                onPressed: createState.isLoading
                    ? null
                    : () async {
                  if (_form.currentState?.validate() ?? false) {
                    await ref
                        .read(createUserControllerProvider.notifier)
                        .submit(
                      CreateUserDto(
                        email: emailCtrl.text.trim(),
                        password: passCtrl.text,
                        fullName: nameCtrl.text.trim(),
                        roleId: _selectedRoleId!, // 👈 include roleId
                      ),
                    );
                    if (mounted) context.pop('/users');
                  }
                },
                child: createState.isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Create'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
