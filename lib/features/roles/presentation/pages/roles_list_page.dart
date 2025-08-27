import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/roles_providers.dart';

class RolesListPage extends ConsumerWidget {
  const RolesListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rolesAsync = ref.watch(rolesListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Roles"),
        leading: IconButton(
          onPressed: () {
            context.go('/admin'); // 👈 go back to admin
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        automaticallyImplyLeading: false,

        // 👉 Add action buttons on right side
        actions: [
          IconButton(
            icon: const Icon(Icons.add), // plus icon
            tooltip: "Create New Role",
            onPressed: () {
              context.push('/roles/create');
              // 👆 navigate to your "create role" page
              // change the route according to your router setup
            },
          ),
        ],
      ),
      body: rolesAsync.when(
        data: (roles) {
          return ListView.builder(
            itemCount: roles.length,
            itemBuilder: (context, index) {
              final role = roles[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 3,
                color: Colors.blueGrey[800], // 👈 background color for visibility
                child: ListTile(
                  contentPadding: const EdgeInsets.all(12),
                  title: Text(
                    role.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  subtitle: Text(
                    role.description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[300],
                    ),
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text("Error: $e")),
      ),
    );
  }
}
