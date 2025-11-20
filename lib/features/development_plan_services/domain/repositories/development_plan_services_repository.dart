import '../../data/models/create_development_plan_service_dto.dart';
import '../../data/models/development_plan_service_dto.dart';

abstract class DevelopmentPlanServicesRepository {
  Future<void> createDevelopmentPlanService(CreateDevelopmentPlanServiceDto dto);
  Future<List<DevelopmentPlanServiceDto>> getAllDevelopmentPlanServices();
  Future<void> updateDevelopmentPlanService(String id, CreateDevelopmentPlanServiceDto dto);
  Future<void> deleteDevelopmentPlanService(String id);
}
