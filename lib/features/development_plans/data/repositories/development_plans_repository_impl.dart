import '../../domain/repositories/development_plans_repository.dart';
import '../models/create_development_plan_dto.dart';
import '../models/development_plan_dto.dart';
import '../sources/development_plan_remote_source.dart';

class DevelopmentPlansRepositoryImpl implements DevelopmentPlansRepository {
  final DevelopmentPlanRemoteSource remoteSource;

  DevelopmentPlansRepositoryImpl(this.remoteSource);

  @override
  Future<List<DevelopmentPlanDto>> getAllDevelopmentPlans() {
    return remoteSource.getAllDevelopmentPlans();
  }

  @override
  Future<void> createDevelopmentPlan(CreateDevelopmentPlanDto dto) {
    return remoteSource.createDevelopmentPlan(dto);
  }

  @override
  Future<void> updateDevelopmentPlan(String id, CreateDevelopmentPlanDto dto) {
    return remoteSource.updateDevelopmentPlan(id, dto);
  }

  @override
  Future<void> deleteDevelopmentPlan(String id) {
    return remoteSource.deleteDevelopmentPlan(id);
  }
}
