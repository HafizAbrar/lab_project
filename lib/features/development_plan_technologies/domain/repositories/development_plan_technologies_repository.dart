import '../../data/models/create_development_plan_technology_dto.dart';
import '../../data/models/development_plan_technology_dto.dart';

abstract class DevelopmentPlanTechnologiesRepository {
  Future<void> createDevelopmentPlanTechnology(CreateDevelopmentPlanTechnologyDto dto);
  Future<List<DevelopmentPlanTechnologyDto>> getAllDevelopmentPlanTechnologies();
  Future<void> updateDevelopmentPlanTechnology(String id, CreateDevelopmentPlanTechnologyDto dto);
  Future<void> deleteDevelopmentPlanTechnology(String id);
}
