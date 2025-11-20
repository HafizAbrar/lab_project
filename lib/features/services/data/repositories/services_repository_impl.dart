import '../../domain/repositories/services_repository.dart';
import '../models/create_service_dto.dart';
import '../models/service_dto.dart';
import '../sources/services_remote_source.dart';

class ServicesRepositoryImpl implements ServicesRepository {
  final ServicesRemoteSource remoteSource;

  ServicesRepositoryImpl(this.remoteSource);

  @override
  Future<List<ServiceDto>> getAllServices() {
    return remoteSource.getAllServices();
  }

  @override
  Future<void> createService(CreateServiceDto dto) {
    return remoteSource.createService(dto);
  }

  @override
  Future<void> updateService(String id, CreateServiceDto dto) {
    return remoteSource.updateService(id, dto);
  }

  @override
  Future<void> deleteService(String id) {
    return remoteSource.deleteService(id);
  }
}
