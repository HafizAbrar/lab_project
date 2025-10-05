import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/employeeProfile_providers.dart';

class EmployeesListPage extends ConsumerWidget {
  const EmployeesListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final employeesAsync = ref.watch(employeesListProvider);
    final profilesAsync = ref.watch(employeeProfilesProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.go('/employees/manage'),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text('Employee List'),
      ),
      body: employeesAsync.when(
        data: (employees) {
          if (employees.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.people_outline, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('No employees found'),
                ],
              ),
            );
          }

          return profilesAsync.when(
            data: (profiles) {
              return RefreshIndicator(
                onRefresh: () async {
                  ref.invalidate(employeesListProvider);
                  ref.invalidate(employeeProfilesProvider);
                },
                child: ListView.builder(
                  itemCount: employees.length,
                  itemBuilder: (context, index) {
                    final employee = employees[index];

                    // Check if profile exists for this employee
                    final profile = profiles
                        .where((p) => p.user?.email == employee.email)
                        .toList()
                        .isNotEmpty
                        ? profiles.firstWhere((p) => p.user?.email == employee.email)
                        : null;

                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Text(
                            (employee.fullName.isNotEmpty
                                ? employee.fullName[0]
                                : employee.email[0])
                                .toUpperCase(),
                          ),
                        ),
                        title: Text(employee.fullName),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(employee.email),
                            const SizedBox(height: 4),
                            Text(
                              employee.roleName,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.blueGrey[700],
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                        trailing: PopupMenuButton(
                          itemBuilder: (context) {
                            // 👇 Show only "Create Profile" if profile doesn’t exist
                            if (profile == null) {
                              return [
                                const PopupMenuItem(
                                  value: 'createProfile',
                                  child: Row(
                                    children: [
                                      Icon(Icons.add_circle_outline),
                                      SizedBox(width: 8),
                                      Text('Create Profile'),
                                    ],
                                  ),
                                ),
                              ];
                            } else {
                              // 👇 Show only "Update Profile" if profile exists
                              return [
                                const PopupMenuItem(
                                  value: 'updateProfile',
                                  child: Row(
                                    children: [
                                      Icon(Icons.edit),
                                      SizedBox(width: 8),
                                      Text('Update Profile'),
                                    ],
                                  ),
                                ),
                              ];
                            }
                          },
                          onSelected: (value) {
                            if (value == 'createProfile') {
                              context.push(
                                '/employees/${employee.id}/create-profile',
                                extra: {
                                  'name': employee.fullName,
                                  'email': employee.email,
                                },
                              );
                            } else if (value == 'updateProfile' && profile != null) {
                              context.push(
                                '/employees/${profile.user?.id}/profiles/${profile.id}/edit',
                                extra: profile,
                              );
                            }
                          },
                        ),
                        onTap: () {},
                      ),
                    );
                  },
                ),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(
              child: Text("Error loading profiles: $error"),
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
                  onPressed: () {
                    ref.refresh(employeesListProvider);
                    ref.refresh(employeeProfilesProvider);
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
