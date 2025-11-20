import '../../domain/repositories/development_plan_services_repository.dart';
import '../models/create_development_plan_service_dto.dart';
import '../models/development_plan_service_dto.dart';
import '../sources/development_plan_service_remote_source.dart';

class DevelopmentPlanServicesRepositoryImpl implements DevelopmentPlanServicesRepository {
  final DevelopmentPlanServiceRemoteSource remoteSource;

  DevelopmentPlanServicesRepositoryImpl(this.remoteSource);

  @override
  Future<void> createDevelopmentPlanService(CreateDevelopmentPlanServiceDto dto) {
    return remoteSource.createDevelopmentPlanService(dto);
  }

  @override
  Future<List<DevelopmentPlanServiceDto>> getAllDevelopmentPlanServices() {
    return remoteSource.getAllDevelopmentPlanServices();
  }

  @override
  Future<void> updateDevelopmentPlanService(String id, CreateDevelopmentPlanServiceDto dto) {
    return remoteSource.updateDevelopmentPlanService(id, dto);
  }

  @override
  Future<void> deleteDevelopmentPlanService(String id) {
    return remoteSource.deleteDevelopmentPlanService(id);
  }
}
