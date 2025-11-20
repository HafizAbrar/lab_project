import '../../domain/repositories/development_plan_technologies_repository.dart';
import '../models/create_development_plan_technology_dto.dart';
import '../models/development_plan_technology_dto.dart';
import '../sources/development_plan_technology_remote_source.dart';

class DevelopmentPlanTechnologiesRepositoryImpl
    implements DevelopmentPlanTechnologiesRepository {
  final DevelopmentPlanTechnologyRemoteSource remoteSource;

  DevelopmentPlanTechnologiesRepositoryImpl(this.remoteSource);

  @override
  Future<void> createDevelopmentPlanTechnology(CreateDevelopmentPlanTechnologyDto dto) {
    return remoteSource.createDevelopmentPlanTechnology(dto);
  }

  @override
  Future<List<DevelopmentPlanTechnologyDto>> getAllDevelopmentPlanTechnologies() {
    return remoteSource.getAllDevelopmentPlanTechnologies();
  }

  @override
  Future<void> updateDevelopmentPlanTechnology(String id, CreateDevelopmentPlanTechnologyDto dto) {
    return remoteSource.updateDevelopmentPlanTechnology(id, dto);
  }

  @override
  Future<void> deleteDevelopmentPlanTechnology(String id) {
    return remoteSource.deleteDevelopmentPlanTechnology(id);
  }
}
