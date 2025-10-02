import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/employeeProfile_providers.dart';


class EmployeesListPage extends ConsumerWidget {
  const EmployeesListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final employeesAsync = ref.watch(employeesListProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.go('/employees/manage'),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text('Employee Profiles'),
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

          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(employeesListProvider);
            },
            child: ListView.builder(
              itemCount: employees.length,
              itemBuilder: (context, index) {
                final employee = employees[index];
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
                      itemBuilder: (context) => [
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
                      ],
                      onSelected: (value) {
                        if (value == 'createProfile') {
                          context.push('/employees/${employee.id}/create-profile');
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
                  onPressed: () => ref.refresh(employeesListProvider),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

//   void _showDeleteDialog(BuildContext context, WidgetRef ref, String employeeId) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Delete Employee'),
//         content: const Text('Are you sure you want to delete this employee?'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(),
//             child: const Text('Cancel'),
//           ),
//           FilledButton(
//             onPressed: () async {
//               Navigator.of(context).pop();
//               try {
//                 await ref.read(deleteEmployeeProvider(employeeId).future);
//                 ref.invalidate(employeesListProvider);
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(content: Text('Employee deleted successfully')),
//                 );
//               } catch (e) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(content: Text('Error deleting employee: $e')),
//                 );
//               }
//             },
//             child: const Text('Delete'),
//           ),
//         ],
//       ),
//     );
//   }
}
