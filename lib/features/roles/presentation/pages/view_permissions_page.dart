// lib/presentation/pages/view_permissions_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lab_app/features/roles/presentation/pages/update_permission_page.dart';
import '../../../permissions/data/modals/permission_dto.dart';
import '../providers/roles_providers.dart';

class ViewPermissionsPage extends ConsumerWidget {
  final String roleId;
  const ViewPermissionsPage({super.key, required this.roleId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final permissionsAsync = ref.watch(rolePermissionsProvider(roleId));

    return Scaffold(
      appBar: AppBar(
        title: const Text("Role Permissions"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_outlined),
            tooltip: "Update Permissions",
            onPressed: () async {
              final updated = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => UpdatePermissionsPage(roleId: roleId),
                ),
              );

              if (updated == true) {
                ref.invalidate(rolePermissionsProvider(roleId));
              }
            },
          )
        ],
      ),
      body: permissionsAsync.when(
        data: (permissions) {
          if (permissions.isEmpty) {
            return const Center(
              child: Text("No permissions assigned to this role"),
            );
          }
          return ListView.builder(
            itemCount: permissions.length,
            itemBuilder: (context, index) {
              final PermissionDto perm = permissions[index];
              return Card(
                margin:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: const Icon(Icons.lock_open, color: Colors.green),
                  title: Text('Feature: ${perm.resource}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('Action: ${perm.action}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () async {
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Remove Permission"),
                          content: Text(
                              "Are you sure you want to remove '${perm.name}' from this role?"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: const Text("Cancel"),
                            ),
                            FilledButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: const Text("Remove"),
                            ),
                          ],
                        ),
                      );

                      if (confirm == true) {
                        try {
                          await ref.read(removePermissionFromRoleProvider({
                            'roleId': roleId,
                            'permissionId': perm.id,
                          }).future);

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(
                                    "Permission '${perm.name}' removed")),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content:
                                Text("Error removing permission: $e")),
                          );
                        }
                      }
                    },
                  ),
                ),
              );
            },
          );
        },
        loading: () =>
        const Center(child: CircularProgressIndicator(strokeWidth: 2)),
        error: (e, _) => Center(child: Text("Error: $e")),
      ),
    );
  }
}
