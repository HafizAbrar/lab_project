
import '../../data/models/create_skill_dto.dart';
import '../../data/models/skills_dto.dart';
import '../../data/models/update_skill_dto.dart';

abstract class SkillsRepository {
  Future<List<SkillDto>> getSkills();
  Future<SkillDto> createSkill(CreateSkillDto dto);
  Future<SkillDto> updateSkill(String skillId, UpdateSkillDto dto);
  Future<void> deleteSkill(String skillId);
}
