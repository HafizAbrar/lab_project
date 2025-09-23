
import '../models/create_skill_dto.dart';
import '../models/skills_dto.dart';
import '../models/update_skill_dto.dart';
import '../sources/skills_remote_source.dart';
import '../../domain/repositories/skills_repository.dart';

class SkillsRepositoryImpl implements SkillsRepository {
  final SkillsRemoteSource remoteSource;

  SkillsRepositoryImpl(this.remoteSource);

  @override
  Future<List<SkillDto>> getSkills() {
    return remoteSource.getSkills();
  }

  @override
  Future<SkillDto> createSkill(CreateSkillDto dto) {
    return remoteSource.createSkill(dto);
  }

  @override
  Future<SkillDto> updateSkill(String skillId, UpdateSkillDto dto) {
    return remoteSource.updateSkill(skillId, dto);
  }

  @override
  Future<void> deleteSkill(String skillId) {
    return remoteSource.deleteSkill(skillId);
  }
}
