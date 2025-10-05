import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/employeeProfile_providers.dart';
import '../../data/models/employee_profile_dto.dart';

class EmployeeProfilesListScreen extends ConsumerWidget {
  const EmployeeProfilesListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profilesAsync = ref.watch(employeeProfilesProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.go('/employees/manage'),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text('Employee Profiles'),
      ),
      body: profilesAsync.when(
        data: (profiles) {
          if (profiles.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.person_outline, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('No profiles found'),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(employeeProfilesProvider);
            },
            child: ListView.builder(
              itemCount: profiles.length,
              itemBuilder: (context, index) {
                final EmployeeProfileDto profile = profiles[index];
                final user = profile.user;

                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.blue.shade100,
                      backgroundImage: (profile.profileImage != null &&
                          profile.profileImage!.isNotEmpty)
                          ? NetworkImage(profile.profileImage!)
                          : null,
                      child: (profile.profileImage == null ||
                          profile.profileImage!.isEmpty)
                          ? Text(
                        user?.fullName.isNotEmpty == true
                            ? user!.fullName[0].toUpperCase()
                            : "?",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      )
                          : null,
                    ),
                    title: Text(user?.fullName ?? "Unknown"),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Job Title: ${profile.jobTitle ?? 'N/A'}"),
                        const SizedBox(height: 4),
                        Text(
                          "Department: ${profile.department ?? 'No Department'}",
                          style: const TextStyle(fontSize: 13),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Status: ${profile.status ?? 'N/A'}",
                          style: TextStyle(
                            fontSize: 12,
                            color: (profile.status == "active")
                                ? Colors.green[700]
                                : Colors.red[700],
                          ),
                        ),
                      ],
                    ),
                    trailing: PopupMenuButton<String>(
                      onSelected: (value) {
                        if (value == 'skillsList') {
                          context.push(
                            '/employee-skills',
                            extra: {
                              'employeeId':profile.userId,
                              'profileId': profile.id,
                              'profileImageUrl': profile.profileImage,
                            },
                          );


                        }else if (value == 'update') {
                          context.push(
                            '/employees/${profile.user?.id}/profiles/${profile.id}/edit',
                            extra: profile, // pass DTO to edit screen
                          );
                        }
                       else if (value == 'delete') {
                          _showDeleteDialog(context, ref, profile.id);
                        }
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: 'skillsList',
                          child: Row(
                            children: [
                              Icon(Icons.list_rounded, color: Colors.blue),
                              SizedBox(width: 8),
                              Text('Show Skills'),
                            ],
                          ),
                        ),
                        const PopupMenuItem(
                          value: 'update',
                          child: Row(
                            children: [
                              Icon(Icons.edit, color: Colors.blue),
                              SizedBox(width: 8),
                              Text('Update'),
                            ],
                          ),
                        ),
                        const PopupMenuItem(
                          value: 'delete',
                          child: Row(
                            children: [
                              Icon(Icons.delete, color: Colors.red),
                              SizedBox(width: 8),
                              Text('Delete'),
                            ],
                          ),
                        ),
                      ],
                    ),
                      onTap: () {
                        context.push('/employees/profiles/${profile.id}');
                      }
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
                  onPressed: () => ref.refresh(employeeProfilesProvider),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, WidgetRef ref, String profileId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Employee Profile'),
        content: const Text('Are you sure you want to delete this profile?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () async {
              Navigator.of(context).pop();
              try {
                await ref.read(deleteEmployeeProfileProvider(profileId).future);
                ref.invalidate(employeeProfilesProvider);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Profile deleted successfully')),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error deleting profile: $e')),
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
