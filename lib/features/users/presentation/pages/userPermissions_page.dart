import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/user_permissions_dto.dart';
import '../providers/users_providers.dart';

class UserPermissionsScreen extends ConsumerWidget {
  final String userId;

  const UserPermissionsScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final permissionsAsync = ref.watch(userPermissionsProvider(userId));

    return Scaffold(
      appBar: AppBar(
        title: const Text("User Permissions"),
      ),
      body: permissionsAsync.when(
        data: (userPerms) {
          if (userPerms.permissions.isEmpty) {
            return const Center(child: Text("No permissions assigned"));
          }

          return ListView.builder(
            itemCount: userPerms.permissions.length,
            itemBuilder: (context, index) {
              final perm = userPerms.permissions[index];
              return ListTile(
                leading: const Icon(Icons.lock),
                title: Text(perm.resource),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(perm.description!),
                    Text("Action: ${perm.action}"),
                  ],
                )
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, st) => Center(
          child: Text("Error: $err"),
        ),
      ),
    );
  }
}
