import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lab_app/features/skills/data/models/create_skill_dto.dart';
import 'package:lab_app/features/skills/data/models/update_skill_dto.dart';
import 'package:lab_app/features/skills/data/repositories/skills_repository_impl.dart';
import 'package:lab_app/features/skills/data/sources/skills_remote_source.dart';
import 'package:lab_app/features/skills/domain/repositories/skills_repository.dart';

import 'package:lab_app/features/roles/presentation/providers/roles_providers.dart';

import '../../data/models/skills_dto.dart';
// ⬆️ reuse dioProvider & secureStorageProvider from roles

// -----------------------
// Remote source provider
// -----------------------
final skillsRemoteSourceProvider =
Provider((ref) => SkillsRemoteSource(ref.read(dioProvider)));

// -----------------------
// Repository provider
// -----------------------
final skillsRepositoryProvider = Provider<SkillsRepository>(
      (ref) => SkillsRepositoryImpl(ref.read(skillsRemoteSourceProvider)),
);

// -----------------------
// Skills list provider
// -----------------------
final skillsListProvider = FutureProvider<List<SkillDto>>((ref) async {
  final repo = ref.read(skillsRepositoryProvider);
  return repo.getSkills();
});

// -----------------------
// Create Skill provider
// -----------------------
final createSkillProvider =
FutureProvider.family<SkillDto, CreateSkillDto>((ref, dto) async {
  final repo = ref.read(skillsRepositoryProvider);
  return repo.createSkill(dto);
});

// -----------------------
// Update Skill provider
// -----------------------
final updateSkillProvider =
FutureProvider.family<SkillDto, Map<String, dynamic>>((ref, params) async {
  final repo = ref.read(skillsRepositoryProvider);
  final String skillId = params['skillId'];
  final UpdateSkillDto dto = params['dto'];
  return repo.updateSkill(skillId, dto);
});

// -----------------------
// Delete Skill provider
// -----------------------
final deleteSkillProvider =
FutureProvider.family<void, String>((ref, skillId) async {
  final repo = ref.read(skillsRepositoryProvider);
  await repo.deleteSkill(skillId);
});
