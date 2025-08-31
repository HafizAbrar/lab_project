import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lab_app/features/users/presentation/pages/userPermissions_page.dart';
import '../providers/users_providers.dart';

class UsersListPage extends ConsumerWidget {
  const UsersListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersAsync = ref.watch(usersListProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.go('/admin'),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text('Users Management'),
        actions: [
          IconButton(
            onPressed: () => context.push('/users/create'),
            icon: const Icon(Icons.add),
            tooltip: 'Add User',
          ),
        ],
      ),
      body: usersAsync.when(
        data: (users) {
          if (users.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.people_outline, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('No users found'),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(usersListProvider);
            },
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return Card(
                  margin:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(
                        (user.fullName?.isNotEmpty == true
                            ? user.fullName![0]
                            : user.email[0])
                            .toUpperCase(),
                      ),
                    ),
                    title: Text(user.fullName ?? 'No Name'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(user.email),
                        const SizedBox(height: 4),
                        Text(
                          user.role?.name ?? 'No Role',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.blueGrey[700],
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                    trailing: PopupMenuButton(
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: 'Apermissions',
                          child: Row(
                            children: [
                              Icon(Icons.assignment_turned_in_outlined),
                              SizedBox(width: 8),
                              Text('Update Permissions'),
                            ],
                          ),
                        ),
                        const PopupMenuItem(
                          value: 'Spermissions',
                          child: Row(
                            children: [
                              Icon(Icons.perm_contact_calendar_outlined),
                              SizedBox(width: 8),
                              Text('Show Permissions'),
                            ],
                          ),
                        ),
                        const PopupMenuItem(
                          value: 'edit',
                          child: Row(
                            children: [
                              Icon(Icons.edit),
                              SizedBox(width: 8),
                              Text('Edit'),
                            ],
                          ),
                        ),
                        const PopupMenuItem(
                          value: 'delete',
                          child: Row(
                            children: [
                              Icon(Icons.delete, color: Colors.red),
                              SizedBox(width: 8),
                              Text('Delete',
                                  style: TextStyle(color: Colors.red)),
                            ],
                          ),
                        ),
                      ],
                      onSelected: (value) async {
                        switch (value) {
                          case 'Apermissions':
                            context.push(
                              '/users/${user.id}/permissions',
                              extra: {
                                'user': user,
                                'mode': PermissionMode.assign,
                              },
                            );
                            break;
                          case 'Spermissions':
                            context.push(
                              '/users/${user.id}/permissions',
                              extra: {
                                'user': user,
                                'mode': PermissionMode.view,
                              },
                            );
                            break;
                          case 'edit':
                            final result = await context.push(
                              '/users/${user.id}/edit',
                              extra: user,
                            );
                            if (result == true) {
                              ref.invalidate(usersListProvider);
                            }
                            break;
                          case 'delete':
                            _showDeleteDialog(context, ref, user.id);
                            break;
                        }
                      },
                    ),
                    onTap: () => context.push('/users/${user.id}'),
                  ),
                );
              },
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error, size: 64, color: Colors.red),
                const SizedBox(height: 16),
                Text('Error: ${error.toString()}'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => ref.refresh(usersListProvider),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, WidgetRef ref, String userId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete User'),
        content: const Text('Are you sure you want to delete this user?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () async {
              Navigator.of(context).pop();
              try {
                await ref.read(deleteUserProvider(userId).future);
                ref.invalidate(usersListProvider);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('User deleted successfully')),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error deleting user: $e')),
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
