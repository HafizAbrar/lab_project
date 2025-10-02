import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/clients_provider.dart';

class ClientsListPage extends ConsumerWidget {
  const ClientsListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clientsAsync = ref.watch(clientsListProvider);
    final profilesAsync = ref.watch(clientProfilesProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.go('/clients/manage'),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text('Client List'),
      ),
      body: clientsAsync.when(
        data: (clients) {
          if (clients.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.people_outline, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('No clients found'),
                ],
              ),
            );
          }

          return profilesAsync.when(
            data: (profiles) {
              return RefreshIndicator(
                onRefresh: () async {
                  ref.invalidate(clientsListProvider);
                  ref.invalidate(clientProfilesProvider);
                },
                child: ListView.builder(
                  itemCount: clients.length,
                  itemBuilder: (context, index) {
                    final client = clients[index];

                    // check if profile exists for this client
                    final profile = profiles
                        .where((p) => p.email == client.email)
                        .toList()
                        .isNotEmpty
                        ? profiles.firstWhere((p) => p.email == client.email)
                        : null;

                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Text(
                            (client.fullName.isNotEmpty
                                ? client.fullName[0]
                                : client.email[0])
                                .toUpperCase(),
                          ),
                        ),
                        title: Text(client.fullName),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(client.email),
                            const SizedBox(height: 4),
                            Text(
                              client.roleName,
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
                                '/clients/${client.id}/create-profile',
                                extra: {
                                  'name': client.fullName,
                                  'email': client.email,
                                },
                              );
                            } else if (value == 'updateProfile' && profile != null) {
                              context.push(
                                '/clients/profiles/${profile.id}/edit',
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
                    ref.refresh(clientsListProvider);
                    ref.refresh(clientProfilesProvider);
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
