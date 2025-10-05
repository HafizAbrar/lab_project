// lib/features/employee_skills/presentation/pages/create_employee_skill_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../skills/presentation/providers/skills_provider.dart';
import '../../data/models/create_employee_skill_dto.dart';
import '../providers/employee_skill_provider.dart';
import '../../data/models/get_skills_of_an_employee_dto.dart';

class CreateEmployeeSkillScreen extends ConsumerStatefulWidget {
  final String employeeId;
  final String? skillId; // 👈 from route
  final EmployeeSkillDto? existingSkill; // 👈 passed from list screen
  final bool isEditing; // 👈 flag for update

  const CreateEmployeeSkillScreen({
    super.key,
    required this.employeeId,
    this.skillId,
    this.existingSkill,
    this.isEditing = false,
  });

  @override
  ConsumerState<CreateEmployeeSkillScreen> createState() =>
      _CreateEmployeeSkillScreenState();
}

class _CreateEmployeeSkillScreenState
    extends ConsumerState<CreateEmployeeSkillScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedSkillId;
  int? _selectedProficiency;
  final _experienceController = TextEditingController();

  final Map<int, String> proficiencyLevels = {
    1: 'Beginner',
    2: 'Intermediate',
    3: 'Expert',
  };

  @override
  void initState() {
    super.initState();
    final existing = widget.existingSkill;
    if (existing != null) {
      _selectedSkillId = existing.skillId;
      _selectedProficiency = existing.proficiencyLevel;
      _experienceController.text =
          existing.yearsOfExperience?.toString() ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isUpdate = widget.isEditing;
    final skillsAsync = ref.watch(skillsListProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(isUpdate ? 'Update Skill' : 'Add Skill'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => context.pop(),
        ),
      ),
      body: skillsAsync.when(
        data: (skills) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  // 👇 Only show Skill dropdown if we are ADDING a skill
                  if (!isUpdate) ...[
                    DropdownButtonFormField<String>(
                      value: _selectedSkillId,
                      items: skills.map<DropdownMenuItem<String>>((skill) {
                        return DropdownMenuItem(
                          value: skill.id,
                          child: Text(skill.name),
                        );
                      }).toList(),
                      decoration: const InputDecoration(
                        labelText: 'Select Skill',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) =>
                          setState(() => _selectedSkillId = value),
                      validator: (value) =>
                      value == null ? 'Please select a skill' : null,
                    ),
                    const SizedBox(height: 16),
                  ],

                  // 👇 Experience field (shown in both modes)
                  TextFormField(
                    controller: _experienceController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Experience (in years)',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter experience';
                      }
                      if (int.tryParse(value) == null) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // 👇 Proficiency field (shown in both modes)
                  DropdownButtonFormField<int>(
                    value: _selectedProficiency,
                    items: proficiencyLevels.entries.map((entry) {
                      return DropdownMenuItem<int>(
                        value: entry.key,
                        child: Text(entry.value),
                      );
                    }).toList(),
                    decoration: const InputDecoration(
                      labelText: 'Proficiency Level',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) =>
                        setState(() => _selectedProficiency = value),
                    validator: (value) =>
                    value == null ? 'Please select proficiency' : null,
                  ),
                  const SizedBox(height: 24),

                  // 👇 Save / Update button
                  FilledButton.icon(
                    icon: Icon(isUpdate ? Icons.update : Icons.save),
                    label: Text(isUpdate ? 'Update Skill' : 'Save Skill'),
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) return;

                      final dto = CreateEmployeeSkillDto(
                        employeeId: widget.employeeId,
                        skillId: _selectedSkillId ?? widget.skillId ?? '',
                        proficiencyLevel: _selectedProficiency!,
                        yearsOfExperience:
                        int.parse(_experienceController.text),
                      );

                      try {
                        if (isUpdate) {
                          await ref
                              .read(updateEmployeeSkillProvider({
                            'employeeId': widget.employeeId,
                            'skillId': widget.skillId ??
                                widget.existingSkill!.skillId!,
                            'dto': dto,
                          }).future);

                          ref.invalidate(getEmployeeSkillsProvider);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Skill updated successfully!'),
                            ),
                          );
                        } else {
                          await ref
                              .read(createEmployeeSkillProvider(dto).future);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Skill added successfully!'),
                            ),
                          );
                        }
                        ref.invalidate(getEmployeeSkillsProvider);
                        context.pop();
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error: $e')),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
      ),
    );
  }

  @override
  void dispose() {
    _experienceController.dispose();
    super.dispose();
  }
}
