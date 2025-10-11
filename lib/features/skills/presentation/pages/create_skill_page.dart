import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../categories/presentation/providers/categories_providers.dart';
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
  String? selectedCategory; // will hold dropdown value

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.skill?.name ?? "");
    descriptionController =
        TextEditingController(text: widget.skill?.description ?? "");
    selectedCategory = widget.skill?.category; // initial selected value
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isUpdate = widget.skill != null;
    final categoriesAsync = ref.watch(getAllCategoriesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(isUpdate ? "Update Skill" : "Create Skill"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: categoriesAsync.when(
          data: (categories) {
            // Filter only category names (avoid duplicates)
            final categoryNames = categories
                .map((c) => c.name)
                .whereType<String>()
                .toSet()
                .toList();

            // ensure selectedCategory exists in dropdown
            if (selectedCategory != null &&
                !categoryNames.contains(selectedCategory)) {
              selectedCategory = null;
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: "Skill Name"),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: descriptionController,
                    decoration:
                    const InputDecoration(labelText: "Description"),
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    decoration:
                    const InputDecoration(labelText: "Select Category"),
                    value: selectedCategory,
                    items: categoryNames
                        .map((cat) => DropdownMenuItem<String>(
                      value: cat,
                      child: Text(cat),
                    ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedCategory = value;
                      });
                    },
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (selectedCategory == null ||
                            selectedCategory!.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Please select a category"),
                            ),
                          );
                          return;
                        }

                        if (isUpdate) {
                          final dto = UpdateSkillDto(
                            name: nameController.text,
                            description: descriptionController.text,
                            category: selectedCategory!,
                          );
                          await ref.read(updateSkillProvider({
                            'skillId': widget.skill!.id,
                            'dto': dto,
                          }).future);
                        } else {
                          final dto = CreateSkillDto(
                            name: nameController.text,
                            description: descriptionController.text,
                            category: selectedCategory!,
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
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text("Error loading categories: $e")),
        ),
      ),
    );
  }
}
