import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../auth/presentation/providers/auth_providers.dart';

class AdminDashboardPage extends ConsumerWidget {
  const AdminDashboardPage({super.key});

  Future<bool> _showExitDialog(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Exit App"),
        content: const Text("Are you sure you want to exit?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text("No"),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text("Yes"),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (!didPop) {
          bool shouldExit = await _showExitDialog(context);
          if (shouldExit) {
            SystemNavigator.pop();
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Admin Dashboard'),
          actions: [
            IconButton(
              onPressed: () async {
                await ref.read(authStateProvider.notifier).logout();
                if (context.mounted) {
                  context.go('/login');
                }
              },
              icon: const Icon(Icons.logout),
            ),
          ],
        ),

        // 🔹 BURGER MENU ADDED
        drawer: Drawer(
          child: authState.when(
            data: (user) {
              return ListView(
                padding: EdgeInsets.zero, // removes default top padding
                children: [
                  UserAccountsDrawerHeader(
                    accountName: Text(user?.name ?? "Admin"),
                    accountEmail: Text(user?.email ?? ""),
                    currentAccountPicture: const CircleAvatar(
                      child: Icon(Icons.admin_panel_settings, size: 32),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.people),
                    title: const Text("Manage Users"),
                    onTap: () {
                      Navigator.pop(context);
                      context.go('/users');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.security),
                    title: const Text("Manage Roles"),
                    onTap: () {
                      Navigator.pop(context);
                      context.go('/roles');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.featured_play_list_outlined),
                    title: const Text("Features"),
                    onTap: () {
                      Navigator.pop(context);
                      context.go('/users/available-features');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.badge),
                    title: const Text("Manage Employees"),
                    onTap: () {
                      Navigator.pop(context);
                      context.go('/employees/manage');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.badge),
                    title: const Text("Manage Clients"),
                    onTap: () {
                      Navigator.pop(context);
                      context.go('/clients/manage');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.pan_tool),
                    title: const Text("Manage Skills"),
                    onTap: () {
                      Navigator.pop(context);
                      context.go('/skills');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.currency_exchange_rounded),
                    title: const Text("Projects"),
                    onTap: () {
                      Navigator.pop(context);
                      context.go('/projects');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.category_outlined),
                    title: const Text("Manage Categories"),
                    onTap: () {
                      Navigator.pop(context);
                      context.go('/categories');
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.exit_to_app),
                    title: const Text("Exit App"),
                    onTap: () async {
                      Navigator.pop(context);
                      bool shouldExit = await _showExitDialog(context);
                      if (shouldExit) {
                        SystemNavigator.pop();
                      }
                    },
                  ),
                ],
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) => Center(child: Text("Error: $error")),
          ),
        ),


        body: authState.when(
          data: (user) {
            if (user == null) {
              return const Center(child: Text('Not logged in'));
            }

            // ✅ KEEPING YOUR EXISTING BODY (Quick Actions + Cards)
            return SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.admin_panel_settings,
                                  size: 48, color: Theme.of(context).primaryColor),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Welcome, ${user.name ?? user.email}!',
                                      style: Theme.of(context).textTheme.headlineSmall,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Role: ${user.role.toUpperCase()}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                        color: user.isAdmin
                                            ? Colors.green
                                            : Colors.blue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const Divider(),
                          const SizedBox(height: 16),
                          Text(
                            'Admin Panel',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Welcome to the administration panel. You have full access to manage the system.',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Quick Actions',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: Card(
                                  child: InkWell(
                                    onTap: () => context.push('/users'),
                                    child: const Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: Column(
                                        children: [
                                          Icon(Icons.people, size: 32),
                                          SizedBox(height: 8),
                                          Text('Manage Users'),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Card(
                                  child: InkWell(
                                    onTap: () => context.push('/roles'),
                                    child: const Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: Column(
                                        children: [
                                          Icon(Icons.security, size: 32),
                                          SizedBox(height: 8),
                                          Text('Manage Roles'),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: Card(
                                  child: InkWell(
                                    onTap: () => context.push('/clients/profiles'),
                                    child: const Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: Column(
                                        children: [
                                          Icon(Icons.people, size: 32),
                                          SizedBox(height: 8),
                                          Text('Clients'),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Card(
                                  child: InkWell(
                                    onTap: () {
                                      context.go('/employees/profiles');
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.people, size: 32),
                                          SizedBox(height: 8),
                                          Text('Employees'),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error, size: 64, color: Colors.red),
                const SizedBox(height: 16),
                Text('Error: $error'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => ref.refresh(authStateProvider),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
