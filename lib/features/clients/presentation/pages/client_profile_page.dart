import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../clients/presentation/providers/clients_provider.dart';

class ClientProfileDetailScreen extends ConsumerWidget {
  final String profileId;
  const ClientProfileDetailScreen({super.key, required this.profileId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(clientProfileProvider(profileId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Client Profile'),
      ),
      body: profileAsync.when(
        data: (profile) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: (profile.profilePhoto.isNotEmpty)
                      ? NetworkImage(profile.profilePhoto)
                      : null,
                  child: (profile.profilePhoto.isEmpty)
                      ? Text(
                    profile.name.isNotEmpty
                        ? profile.name[0].toUpperCase()
                        : "?",
                    style: const TextStyle(
                        fontSize: 32, fontWeight: FontWeight.bold),
                  )
                      : null,
                ),
                const SizedBox(height: 16),
                if (profile.name.isNotEmpty)
                  Text(
                    profile.name,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                const Divider(height: 32),

                // Show only non-null / non-empty fields
                if (profile.email != null && profile.email.isNotEmpty)
                  _buildDetailRow("E-mail", profile.email),

                if (profile.phone != null && profile.phone.isNotEmpty)
                  _buildDetailRow("Phone", profile.phone),

                if (profile.company != null && profile.company.isNotEmpty)
                  _buildDetailRow("Company", profile.company!),

                if (profile.address != null && profile.address.isNotEmpty)
                  _buildDetailRow("Address", profile.address),

                if (profile.website != null && profile.website.isNotEmpty)
                  _buildDetailRow("Website", profile.website!),
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
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
