import 'package:dio/dio.dart';
import '../models/service_dto.dart';
import '../models/create_service_dto.dart';

class ServicesRemoteSource {
  final Dio dio;

  ServicesRemoteSource(this.dio);

  Future<List<ServiceDto>> getAllServices() async {
    final response = await dio.get('/services');
    return (response.data as List)
        .map((json) => ServiceDto.fromJson(json))
        .toList();
  }

  Future<void> createService(CreateServiceDto dto) async {
    await dio.post('/services', data: dto.toJson());
  }

  Future<void> updateService(String id, CreateServiceDto dto) async {
    await dio.put('/services/$id', data: dto.toJson());
  }

  Future<void> deleteService(String id) async {
    await dio.delete('/services/$id');
  }
}
