import '../../data/models/create_development_plan_dto.dart';
import '../../data/models/development_plan_dto.dart';

abstract class DevelopmentPlansRepository {
  Future<List<DevelopmentPlanDto>> getAllDevelopmentPlans();
  Future<void> createDevelopmentPlan(CreateDevelopmentPlanDto dto);
  Future<void> updateDevelopmentPlan(String id, CreateDevelopmentPlanDto dto);
  Future<void> deleteDevelopmentPlan(String id);
}
