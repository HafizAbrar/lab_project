import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/skills_provider.dart';
import 'create_skill_page.dart';


class SkillsScreen extends ConsumerWidget {
  const SkillsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final skillsAsync = ref.watch(skillsListProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/admin');
          },
        ),
        title: const Text("Manage Skills"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const CreateOrUpdateSkillScreen(),
                ),
              ).then((_) => ref.refresh(skillsListProvider));
            },
          ),
        ],
      ),
      body: skillsAsync.when(
        data: (skills) => ListView.builder(
          itemCount: skills.length,
          itemBuilder: (context, index) {
            final skill = skills[index];
            return ListTile(
              leading: const Icon(Icons.star),
              title: Text(skill.name),
              subtitle: Text(skill.category ?? "No category"),
              trailing: PopupMenuButton<String>(
                onSelected: (value) async {
                  if (value == 'update') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CreateOrUpdateSkillScreen(skill: skill),
                      ),
                    ).then((_) => ref.refresh(skillsListProvider));
                  } else if (value == 'delete') {
                    await ref
                        .read(deleteSkillProvider(skill.id).future)
                        .then((_) => ref.refresh(skillsListProvider));
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'update',
                    child: Row(
                      children: const [
                        Icon(Icons.edit, color: Colors.blue),
                        SizedBox(width: 8),
                        Text('Update'),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: const [
                        Icon(Icons.delete, color: Colors.red),
                        SizedBox(width: 8),
                        Text('Delete'),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        loading: () =>
        const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text("Error: $err")),
      ),
    );
  }
}
