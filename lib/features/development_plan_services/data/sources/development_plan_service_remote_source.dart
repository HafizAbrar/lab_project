import 'package:dio/dio.dart';
import '../models/create_development_plan_service_dto.dart';
import '../models/development_plan_service_dto.dart';

class DevelopmentPlanServiceRemoteSource {
  final Dio dio;

  DevelopmentPlanServiceRemoteSource(this.dio);

  Future<void> createDevelopmentPlanService(CreateDevelopmentPlanServiceDto dto) async {
    await dio.post('/development-plan-services', data: dto.toJson());
  }

  Future<List<DevelopmentPlanServiceDto>> getAllDevelopmentPlanServices() async {
    final response = await dio.get('/development-plan-services');
    return (response.data as List)
        .map((json) => DevelopmentPlanServiceDto.fromJson(json))
        .toList();
  }

  Future<void> updateDevelopmentPlanService(String id, CreateDevelopmentPlanServiceDto dto) async {
    await dio.put('/development-plan-services/$id', data: dto.toJson());
  }

  Future<void> deleteDevelopmentPlanService(String id) async {
    await dio.delete('/development-plan-services/$id');
  }
}
