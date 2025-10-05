import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/employee_skill_provider.dart';

class EmployeeSkillsScreen extends ConsumerWidget {
  final String profileId;
  final String employeeId;
  final String profileImageUrl; // 👈 Add this field to receive from previous screen

  const EmployeeSkillsScreen({
    super.key,
    required this.profileId,
    required this.employeeId,
    required this.profileImageUrl, // 👈 Required in constructor
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final skillsAsync = ref.watch(getEmployeeSkillsProvider(profileId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Skills'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Add Skill',
            onPressed: () {
              context.push('/employee-skills/${employeeId}/create');
            },
          ),
        ],
      ),
      body: skillsAsync.when(
        data: (skills) {
          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(getEmployeeSkillsProvider(profileId));
              await ref.read(getEmployeeSkillsProvider(profileId).future);
            },
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                const SizedBox(height: 16),

                // 👇 Employee profile image section
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[300],
                    backgroundImage: profileImageUrl.isNotEmpty
                        ? NetworkImage(profileImageUrl)
                        : null,
                    child: profileImageUrl.isEmpty
                        ? const Icon(Icons.person, size: 50, color: Colors.white)
                        : null,
                  ),
                ),
                const SizedBox(height: 12),
                const Divider(thickness: 1),

                // 👇 Skills section
                if (skills.isEmpty)
                  const Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: Center(child: Text('No skills found')),
                  )
                else
                  ...skills.map((skill) {
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      child: ListTile(
                        title: Text(skill.skillName ?? 'Unknown Skill'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Category: ${skill.category ?? 'N/A'}'),
                            const SizedBox(height: 4),
                            Text('Proficiency: ${skill.proficiencyLevel?.toString() ?? 'N/A'}'),
                            const SizedBox(height: 4),
                            Text(
                              'Experience: ${skill.yearsOfExperience ?? 'N/A'} years',
                              style: const TextStyle(color: Colors.green),
                            ),
                          ],
                        ),
                        trailing: PopupMenuButton<String>(
                          onSelected: (value) async {
                            if (value == 'update') {
                              context.pushNamed(
                                'updateEmployeeSkill',
                                pathParameters: {
                                  'employeeId': profileId,
                                  'skillId': skill.skillId!,
                                },
                                extra: {'skill': skill},
                              );
                            } else if (value == 'delete') {
                              _showDeleteDialog(context, ref, profileId, skill.skillId!);
                            }
                          },
                          itemBuilder: (context) => [
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
                      ),
                    );
                  }).toList(),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
      ),
    );
  }

  void _showDeleteDialog(
      BuildContext context, WidgetRef ref, String employeeId, String skillId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Skill'),
        content: const Text('Are you sure you want to delete this skill?'),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () async {
              try {
                await ref.read(deleteEmployeeSkillProvider({
                  'employeeId': employeeId,
                  'skillId': skillId,
                }).future);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Skill deleted successfully!')),
                );

                context.pop(); // close dialog
                ref.invalidate(getEmployeeSkillsProvider(employeeId));
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: $e')),
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
