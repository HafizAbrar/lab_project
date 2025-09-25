// lib/presentation/pages/update_permissions_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../users/presentation/providers/users_providers.dart'
    hide allPermissionsProvider;
import '../providers/roles_providers.dart';

class UpdatePermissionsPage extends ConsumerStatefulWidget {
  final String roleId;

  const UpdatePermissionsPage({super.key, required this.roleId});

  @override
  ConsumerState<UpdatePermissionsPage> createState() =>
      _UpdatePermissionsPageState();
}

class _UpdatePermissionsPageState
    extends ConsumerState<UpdatePermissionsPage> {
  final Set<String> _selectedPermissions = {};

  @override
  void initState() {
    super.initState();
    // Load pre-assigned permissions
    Future.microtask(() async {
      final assigned =
      await ref.read(rolePermissionsProvider(widget.roleId).future);
      setState(() {
        _selectedPermissions.addAll(assigned.map((p) => p.id));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final allPermissionsAsync = ref.watch(allPermissionsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Role Permissions"),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () async {
              await ref.read(updateRolePermissionsProvider({
                'roleId': widget.roleId,
                'permissionIds': _selectedPermissions.toList(),
              }).future);

              // Invalidate so provider fetches again
              ref.invalidate(rolePermissionsProvider(widget.roleId));

              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text("Permissions updated successfully!")),
                );
                Navigator.pop(context, true); // ✅ return true if updated
              }
            },
          )
        ],
      ),
      body: allPermissionsAsync.when(
        data: (allPermissions) {
          if (allPermissions.isEmpty) {
            return const Center(child: Text("No permissions available"));
          }

          return ListView.builder(
            itemCount: allPermissions.length,
            itemBuilder: (context, index) {
              final perm = allPermissions[index];
              final isSelected = _selectedPermissions.contains(perm.id);

              return ListTile(
                leading: const Icon(Icons.lock),
                title: Text(perm.name),
                subtitle: Text(perm.description ?? ""),
                trailing: Checkbox(
                  value: isSelected,
                  onChanged: (val) {
                    setState(() {
                      if (val == true) {
                        _selectedPermissions.add(perm.id);
                      } else {
                        _selectedPermissions.remove(perm.id);
                      }
                    });
                  },
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text("Error: $e")),
      ),
    );
  }
}
