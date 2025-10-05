import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../employeeSkills/presentation/providers/employee_skill_provider.dart';
import '../providers/employeeProfile_providers.dart';

class EmployeeProfileDetailScreen extends ConsumerWidget {
  final String profileId;
  const EmployeeProfileDetailScreen({super.key, required this.profileId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(employeeProfileProvider(profileId));
    final skillsAsync = ref.watch(getEmployeeSkillsProvider(profileId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Profile'),
      ),
      body: profileAsync.when(
        data: (profile) {
          final user = profile.user;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 👤 Profile Image
                Center(
                  child: CircleAvatar(
                    radius: 60,
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
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                        : null,
                  ),
                ),
                const SizedBox(height: 16),

                // 🧾 Profile Details
                Center(
                  child: Text(
                    user?.fullName ?? "Unknown",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 8),
                Center(child: Text(user?.email ?? "No email")),
                const Divider(height: 32),

                _buildDetailRow("Hire Date", profile.hireDate ?? "N/A"),
                _buildDetailRow("Job Title", profile.jobTitle ?? "N/A"),
                _buildDetailRow("Department", profile.department ?? "N/A"),
                _buildDetailRow("Status", profile.status ?? "N/A"),

                const SizedBox(height: 24),
                const Divider(),
                Center(
                  child: const Text(
                    "Employee Skills",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 12),

                // 🎯 Skills List
                skillsAsync.when(
                  data: (skills) {
                    if (skills.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: Center(child: Text("No skills found")),
                      );
                    }
                    return Column(
                      children: skills.map((skill) {
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          elevation: 2,
                          child: ListTile(
                            title: Text(skill.skillName ?? "Unknown Skill"),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 4),
                                Text("Category: ${skill.category ?? "N/A"}"),
                                const SizedBox(height: 4),
                                Text(
                                    "Proficiency: ${skill.proficiencyLevel?.toString() ?? "N/A"}"),
                                const SizedBox(height: 4),
                                Text(
                                  "Experience: ${skill.yearsOfExperience ?? "N/A"} years",
                                  style:
                                  const TextStyle(color: Colors.green),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  },
                  loading: () => const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  error: (error, _) =>
                      Center(child: Text("Error loading skills: $error")),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) =>
            Center(child: Text("Error: ${error.toString()}")),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }
}
