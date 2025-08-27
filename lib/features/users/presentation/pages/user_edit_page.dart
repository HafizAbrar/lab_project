import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../roles/presentation/providers/roles_providers.dart';
import '../../data/models/update_user_dto.dart';
import '../providers/users_providers.dart';
import '../../data/models/user_dto.dart';

class EditUserPage extends ConsumerStatefulWidget {
  final String userId;
  final UserDto? user;

  const EditUserPage({
    super.key,
    required this.userId,
    this.user,
  });

  @override
  ConsumerState<EditUserPage> createState() => _EditUserPageState();
}

class _EditUserPageState extends ConsumerState<EditUserPage> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  String? _selectedRoleId; // 👈 moved inside the state

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user?.fullName ?? '');
    _emailController = TextEditingController(text: widget.user?.email ?? '');
    _passwordController = TextEditingController(text: ''); // empty for unchanged
    _selectedRoleId = widget.user?.role?.id; // 👈 initial value
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final updateState = ref.watch(updateUserControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Edit User')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Full Name'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password (leave empty to keep old)',
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            ref.watch(rolesListProvider).when(
              data: (roles) {
                return DropdownButtonFormField<String>(
                  value: _selectedRoleId,
                  decoration: const InputDecoration(labelText: 'Role'),
                  items: roles.map((role) {
                    return DropdownMenuItem<String>(
                      value: role.id,
                      child: Text(role.name),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedRoleId = value;
                    });
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Text('Error loading roles: $err'),
            ),
            const SizedBox(height: 24),
            updateState.isLoading
                ? const Center(child: CircularProgressIndicator())
                : ElevatedButton(
              onPressed: () async {
                try {
                  await ref
                      .read(updateUserControllerProvider.notifier)
                      .submit(
                    widget.user!.id,
                    UpdateUserDto(
                      fullName: _nameController.text,
                      email: _emailController.text,
                      password: _passwordController.text.isNotEmpty
                          ? _passwordController.text
                          : null,
                      roleId: _selectedRoleId ?? '',
                    ),
                  );

                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('User updated successfully!'),
                      ),
                    );
                    context.pop(true); // 👈 return success
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: $e')),
                  );
                }
              },
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
