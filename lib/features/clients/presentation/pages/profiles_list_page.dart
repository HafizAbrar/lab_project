import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../data/models/client_profile_dto.dart';
import '../providers/clients_provider.dart';

class ClientProfilesListScreen extends ConsumerWidget {
  const ClientProfilesListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profilesAsync = ref.watch(clientProfilesProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.go('/clients/manage'),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text('Client Profiles'),
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
              ref.invalidate(clientProfilesProvider);
            },
            child: ListView.builder(
              itemCount: profiles.length,
              itemBuilder: (context, index) {
                final ClientProfileDto profile = profiles[index];

                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.green.shade100,
                      backgroundImage: (profile.profilePhoto.isNotEmpty)
                          ? NetworkImage(profile.profilePhoto)
                          : null,
                      child: (profile.profilePhoto.isEmpty)
                          ? Text(
                        profile.name.isNotEmpty == true
                            ? profile.name[0].toUpperCase()
                            : "?",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      )
                          : null,
                    ),
                    title: Text(profile.name ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Email: ${profile.email}"),
                        const SizedBox(height: 4),
                        Text("Phone: ${profile.phone  }"),
                        // const SizedBox(height: 4),
                        // Text("Company: ${profile.company }"),
                      ],
                    ),
                    trailing: PopupMenuButton<String>(
                      onSelected: (value) {
                        if (value == 'update') {
                          context.push(
                            '/clients/profiles/${profile.id}/edit',
                            extra: profile, // pass DTO to edit screen
                          );
                        } else if (value == 'delete') {
                          _showDeleteDialog(context, ref, profile.id);
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
                    onTap: () {
                      context.push('/clients/profiles/${profile.id}');
                    },
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
                  onPressed: () => ref.refresh(clientProfilesProvider),
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
        title: const Text('Delete Client Profile'),
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
                await ref.read(deleteClientProfileProvider(profileId).future);
                ref.invalidate(clientProfilesProvider);
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
