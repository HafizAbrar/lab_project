import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/create_skill_dto.dart';
import '../../data/models/update_skill_dto.dart';
import '../../data/models/skills_dto.dart';
import '../providers/skills_provider.dart';

class CreateOrUpdateSkillScreen extends ConsumerStatefulWidget {
  final SkillDto? skill;

  const CreateOrUpdateSkillScreen({super.key, this.skill});

  @override
  ConsumerState<CreateOrUpdateSkillScreen> createState() =>
      _CreateOrUpdateSkillScreenState();
}

class _CreateOrUpdateSkillScreenState
    extends ConsumerState<CreateOrUpdateSkillScreen> {
  late TextEditingController nameController;
  late TextEditingController descriptionController;
  late TextEditingController categoryController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.skill?.name ?? "");
    descriptionController =
        TextEditingController(text: widget.skill?.description ?? "");
    categoryController =
        TextEditingController(text: widget.skill?.category ?? "");
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isUpdate = widget.skill != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isUpdate ? "Update Skill" : "Create Skill"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Skill Name"),
            ),
            SizedBox(height: 20,),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: "Description"),
            ),
            SizedBox(height: 20,),
            TextField(
              controller: categoryController,
              decoration: const InputDecoration(labelText: "Category"),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  if (isUpdate) {
                    final dto = UpdateSkillDto(
                      name: nameController.text,
                      description: descriptionController.text,
                      category: categoryController.text,
                    );
                    await ref.read(updateSkillProvider({
                      'skillId': widget.skill!.id,
                      'dto': dto,
                    }).future);
                  } else {
                    final dto = CreateSkillDto(
                      name: nameController.text,
                      description: descriptionController.text,
                      category: categoryController.text,
                    );
                    await ref.read(createSkillProvider(dto).future);
                  }

                  if (context.mounted) Navigator.pop(context);
                },
                child: Text(isUpdate ? "Update" : "Create"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
