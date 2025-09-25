import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../data/models/role_dto.dart';
import '../providers/roles_providers.dart';

class RolesListPage extends ConsumerWidget {
  const RolesListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rolesAsync = ref.watch(rolesListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Roles Management'),
        leading: IconButton(
          onPressed: () => context.go('/admin'),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Create Role',
            onPressed: () => context.push('/roles/create'),
          ),
        ],
      ),
      body: rolesAsync.when(
        data: (roles) {
          if (roles.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.security, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('No roles found'),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(rolesListProvider),
            child: ListView.builder(
              itemCount: roles.length,
              itemBuilder: (context, index) {
                final role = roles[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    title: Text(
                      role.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // ✅ visible on white card
                      ),
                    ),
                    subtitle: Text(
                      role.description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[300],
                      ),
                    ),
                    trailing: PopupMenuButton<String>( // ✅ FIXED
                      itemBuilder: (context) => [
                        const PopupMenuItem<String>(
                          value: 'viewPermissions',
                          child: Row(
                            children: [
                              Icon(Icons.visibility),
                              SizedBox(width: 8),
                              Text('View Permissions'),
                            ],
                          ),
                        ),
                        const PopupMenuItem<String>(
                          value: 'updatePermissions',
                          child: Row(
                            children: [
                              Icon(Icons.edit_attributes),
                              SizedBox(width: 8),
                              Text('Update Permissions'),
                            ],
                          ),
                        ),
                        const PopupMenuDivider(),
                        const PopupMenuItem<String>(
                          value: 'edit',
                          child: Row(
                            children: [
                              Icon(Icons.edit),
                              SizedBox(width: 8),
                              Text('Edit Role'),
                            ],
                          ),
                        ),
                        const PopupMenuItem<String>(
                          value: 'delete',
                          child: Row(
                            children: [
                              Icon(Icons.delete, color: Colors.red),
                              SizedBox(width: 8),
                              Text(
                                'Delete',
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                      ],
                      onSelected: (value) async {
                        switch (value) {
                          case 'viewPermissions':
                            context.push(
                              '/roles/permissions/view',
                              extra: role.id, // ✅ pass roleId
                            );
                            break;
                          case 'updatePermissions':
                            final updated = await context.pushNamed<bool>(
                              'updateRolePermissions',
                              pathParameters: {'roleId': role.id}, // ✅ FIXED
                            );
                            if (updated == true) {
                              ref.invalidate(rolesListProvider);
                            }
                            break;
                          case 'edit':
                            final updatedRole = await context.push<RoleDto>(
                              '/roles/edit',
                              extra: role,
                            );
                            if (updatedRole != null) {
                              ref.invalidate(rolesListProvider);
                            }
                            break;
                          case 'delete':
                            _showDeleteDialog(context, ref, role.id);
                            break;
                        }
                      },
                    ),
                  ),
                );
              },
            ),
          );
        },
        loading: () =>
        const Center(child: CircularProgressIndicator(strokeWidth: 2)),
        error: (e, _) => Center(child: Text("Error: $e")),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, WidgetRef ref, String roleId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Role'),
        content: const Text('Are you sure you want to delete this role?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () async {
              Navigator.of(context).pop();
              try {
                await ref.read(deleteRoleProvider(roleId).future);
                ref.invalidate(rolesListProvider);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Role deleted successfully')),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error deleting role: $e')),
                );
              }
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
