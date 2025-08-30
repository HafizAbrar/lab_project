import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../permissions/data/modals/permission_dto.dart';
import '../../../permissions/presentation/providers/permission_provider.dart';
import '../../../roles/presentation/providers/roles_providers.dart';
import '../../data/models/createUserWithPermission_dto.dart';
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
  List<String> _selectedPermissionIds = [];
  bool _assignPermissions = false; // 👈 checkbox state
  String? _selectedRoleId; // 👈 track selected role
  Future<void> _showPermissionDialog(
      BuildContext context, List<PermissionDto> permissions) async {
    final tempSelected = List<String>.from(_selectedPermissionIds);

    TextEditingController searchController = TextEditingController();
    List<PermissionDto> filteredPermissions = List.from(permissions);

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            void _filterPermissions(String query) {
              setState(() {
                if (query.isEmpty) {
                  filteredPermissions = List.from(permissions);
                } else {
                  filteredPermissions = permissions
                      .where((perm) =>
                  perm.name.toLowerCase().contains(query.toLowerCase()) ||
                      perm.description
                          !.toLowerCase()
                          .contains(query.toLowerCase()))
                      .toList();
                }
              });
            }

            return AlertDialog(
              title: const Text("Select Permissions"),
              content: SizedBox(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // 🔎 Search bar
                    TextField(
                      controller: searchController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: "Search permissions...",
                      ),
                      onChanged: _filterPermissions,
                    ),
                    const SizedBox(height: 10),
                    // Permissions list
                    Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        children: filteredPermissions.map((perm) {
                          return CheckboxListTile(
                            title: Text(perm.name),
                            subtitle: Text(perm.description!),
                            value: tempSelected.contains(perm.id),
                            onChanged: (checked) {
                              setState(() {
                                if (checked == true) {
                                  tempSelected.add(perm.id);
                                } else {
                                  tempSelected.remove(perm.id);
                                }
                              });
                            },
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedPermissionIds = tempSelected;
                    });
                    Navigator.pop(context);
                  },
                  child: const Text("Done"),
                ),
              ],
            );
          },
        );
      },
    );

    setState(() {}); // refresh chips after dialog closes
  }

  @override
  Widget build(BuildContext context) {
    final createState = ref.watch(createUserControllerProvider);
    final rolesAsync = ref.watch(rolesListProvider);
    final permissionsAsync = ref.watch(permissionsListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Add User')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              // --- Name ---
              TextFormField(
                controller: nameCtrl,
                decoration: const InputDecoration(labelText: 'Full name'),
                validator: (v) =>
                (v == null || v.trim().length < 2)
                    ? 'Enter at least 2 characters'
                    : null,
              ),
              const SizedBox(height: 12),

              // --- Email ---
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

              // --- Password ---
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
                        value: role.id,
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

              // --- Checkbox for permissions ---
              CheckboxListTile(
                value: _assignPermissions,
                onChanged: (val) {
                  setState(() {
                    _assignPermissions = val ?? false;
                    if (!_assignPermissions) {
                      _selectedPermissionIds.clear();
                    }
                  });
                },
                title: const Text("Assign custom permissions to this user?"),
              ),
              const SizedBox(height: 8),

              // --- Permissions Section (only if checkbox is checked) ---
              if (_assignPermissions)
                permissionsAsync.when(
                  data: (permissions) {
                    return InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Permissions',
                        border: OutlineInputBorder(),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            spacing: 8,
                            children: _selectedPermissionIds.map((id) {
                              final perm = permissions.firstWhere((p) => p.id == id);
                              return Chip(
                                label: Text(perm.name),
                                onDeleted: () {
                                  setState(() {
                                    _selectedPermissionIds.remove(id);
                                  });
                                },
                              );
                            }).toList(),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton.icon(
                              icon: const Icon(Icons.add),
                              label: const Text("Select Permissions"),
                              onPressed: () {
                                _showPermissionDialog(context, permissions);
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (e, _) => Text("Failed to load permissions: $e"),
                ),

              // --- Error if any ---
              if (createState is AsyncError)
                Text(
                  createState.error.toString(),
                  style: const TextStyle(color: Colors.red),
                ),

              const SizedBox(height: 8),

              // --- Submit button ---
              FilledButton(
                onPressed: createState.isLoading
                    ? null
                    : () async {
                  if (_form.currentState?.validate() ?? false) {
                    if (_assignPermissions) {
                      // ✅ Create user with permissions
                      await ref
                          .read(createUserWithPermissionsControllerProvider.notifier)
                          .submit(
                        CreateUserWithPermissionsDto(
                          email: emailCtrl.text.trim(),
                          password: passCtrl.text,
                          fullName: nameCtrl.text.trim(),
                          roleId: _selectedRoleId ?? "",
                          permissionIds: _selectedPermissionIds,
                        ),
                      );
                    } else {
                      // ✅ Create user with role only
                      await ref.read(createUserControllerProvider.notifier).submit(
                        CreateUserDto(
                          email: emailCtrl.text.trim(),
                          password: passCtrl.text,
                          fullName: nameCtrl.text.trim(),
                          roleId: _selectedRoleId!,
                        ),
                      );
                    }
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