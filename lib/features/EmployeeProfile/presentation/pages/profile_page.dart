import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/employeeProfile_providers.dart';

class EmployeeProfileDetailScreen extends ConsumerWidget {
  final String profileId;
  const EmployeeProfileDetailScreen({super.key, required this.profileId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(employeeProfileProvider(profileId));

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
              children: [
                CircleAvatar(
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
                        fontSize: 32, fontWeight: FontWeight.bold),
                  )
                      : null,
                ),
                const SizedBox(height: 16),
                Text(
                  user?.fullName ?? "Unknown",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(user?.email ?? "No email"),
                const Divider(height: 32),

                _buildDetailRow("Hire Date", profile.hireDate ?? "N/A"),
                _buildDetailRow("Job Title", profile.jobTitle ?? "N/A"),
                _buildDetailRow("Department", profile.department ?? "N/A"),
                _buildDetailRow("Status", profile.status ?? "N/A"),
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