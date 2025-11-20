import '../../data/models/create_service_dto.dart';
import '../../data/models/service_dto.dart';

abstract class ServicesRepository {
  Future<List<ServiceDto>> getAllServices();
  Future<void> createService(CreateServiceDto dto);
  Future<void> updateService(String id, CreateServiceDto dto);
  Future<void> deleteService(String id);
}
