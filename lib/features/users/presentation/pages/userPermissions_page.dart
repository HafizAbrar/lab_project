import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lab_app/features/users/data/models/user_permissions_dto.dart';
import '../../../permissions/data/modals/permission_dto.dart';
import '../../data/models/updatePermissions_dto.dart';
import '../providers/users_providers.dart';

enum PermissionMode { view, assign }

// 🔍 Search query provider
final searchQueryProvider = StateProvider<String>((ref) => "");

class UserPermissionsScreen extends ConsumerWidget {
  final String userId;
  final PermissionMode mode;

  const UserPermissionsScreen({
    super.key,
    required this.userId,
    required this.mode,
  });

  Map<String, Set<String>> _groupByFeature(
      List<PermissionDto> allPerms, Set<String> permIds) {
    final Map<String, Set<String>> grouped = {};
    for (final perm in allPerms.where((p) => permIds.contains(p.id))) {
      grouped.putIfAbsent(perm.resource, () => {});
      grouped[perm.resource]!.add(perm.action);
    }
    return grouped;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userPermsAsync = ref.watch(userPermissionsProvider(userId));
    final allPermsAsync = ref.watch(allPermissionsProvider);
    final selectedPerms = ref.watch(selectedPermissionsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          mode == PermissionMode.assign
              ? "Update Permissions"
              : "User Permissions",
        ),
        actions: [
          if (mode == PermissionMode.assign)
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: () async {
                final selectedIds = ref.read(selectedPermissionsProvider);
                final allPerms = await ref.read(allPermissionsProvider.future);
                final userPerms =
                await ref.read(userPermissionsProvider(userId).future);

                final repo = ref.read(usersRepositoryProvider);

                final currentIds =
                userPerms.permissions.map((p) => p.id).toSet();

                final toAdd = selectedIds.difference(currentIds);
                final toRemove = currentIds.difference(selectedIds);

                try {
                  if (toAdd.isNotEmpty) {
                    final addGrouped = _groupByFeature(allPerms, toAdd);
                    for (final entry in addGrouped.entries) {
                      final dto = UpdatePermissionDto(
                        feature: entry.key,
                        actions: entry.value.toList(),
                        assignmentAction: "add",
                      );
                      await repo.assignPermissions(userId, dto);
                    }
                  }

                  if (toRemove.isNotEmpty) {
                    final removeGrouped = _groupByFeature(allPerms, toRemove);
                    for (final entry in removeGrouped.entries) {
                      final dto = UpdatePermissionDto(
                        feature: entry.key,
                        actions: entry.value.toList(),
                        assignmentAction: "remove",
                      );
                      await repo.assignPermissions(userId, dto);
                    }
                  }

                  ref.invalidate(userPermissionsProvider(userId));

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("✅ Permissions updated successfully")),
                  );

                  context.pop();
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("❌ Failed: $e")),
                  );
                }
              },
            ),
        ],
      ),
      body: mode == PermissionMode.assign
          ? _buildAssignUI(
          context, ref, allPermsAsync, userPermsAsync, selectedPerms, userId)
          : _buildViewUI(userPermsAsync),
    );
  }

  /// ✅ Assign UI with Search Bar
  Widget _buildAssignUI(
      BuildContext context,
      WidgetRef ref,
      AsyncValue<List<PermissionDto>> allPermsAsync,
      AsyncValue<UserPermissionsDto> userPermsAsync,
      Set<String> selectedPerms,
      String userId,
      ) {
    final searchQuery = ref.watch(searchQueryProvider);

    return Column(
      children: [
        // 🔍 Search Bar
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: "Search permissions...",
              border: OutlineInputBorder(),
            ),
            onChanged: (value) =>
            ref.read(searchQueryProvider.notifier).state = value,
          ),
        ),

        Expanded(
          child: allPermsAsync.when(
            data: (allPerms) {
              return userPermsAsync.when(
                data: (userPerms) {
                  if (selectedPerms.isEmpty &&
                      userPerms.permissions.isNotEmpty) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      ref
                          .read(selectedPermissionsProvider.notifier)
                          .setPermissions(
                        userPerms.permissions.map((p) => p.id).toSet(),
                      );
                    });
                  }

                  // 🔍 Filter permissions by search
                  final filteredPerms = allPerms.where((perm) {
                    final query = searchQuery.toLowerCase();
                    return perm.resource.toLowerCase().contains(query) ||
                        perm.action.toLowerCase().contains(query);
                  }).toList();

                  if (filteredPerms.isEmpty) {
                    return const Center(
                        child: Text("No permissions found for your search"));
                  }

                  return ListView.builder(
                    itemCount: filteredPerms.length,
                    itemBuilder: (context, index) {
                      final perm = filteredPerms[index];
                      final isSelected = selectedPerms.contains(perm.id);

                      return CheckboxListTile(
                        value: isSelected,
                        title: Text("Feature: ${perm.resource}"),
                        subtitle: Text("Action: ${perm.action}"),
                        onChanged: (_) {
                          ref
                              .read(selectedPermissionsProvider.notifier)
                              .togglePermission(perm.id);
                        },
                      );
                    },
                  );
                },
                loading: () =>
                const Center(child: CircularProgressIndicator()),
                error: (err, st) => Center(child: Text("Error: $err")),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, st) => Center(child: Text("Error: $err")),
          ),
        ),
      ],
    );
  }

  /// ✅ View UI - unchanged
  Widget _buildViewUI(AsyncValue<UserPermissionsDto> userPermsAsync) {
    return userPermsAsync.when(
      data: (userPerms) {
        if (userPerms.permissions.isEmpty) {
          return const Center(child: Text("No permissions assigned"));
        }

        return ListView.builder(
          itemCount: userPerms.permissions.length,
          itemBuilder: (context, index) {
            final perm = userPerms.permissions[index];
            return ListTile(
              leading:
              const Icon(Icons.check_circle, color: Colors.green),
              title: Text("Feature: ${perm.resource}"),
              subtitle: Text("Action: ${perm.action}"),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, st) => Center(child: Text("Error: $err")),
    );
  }
}
