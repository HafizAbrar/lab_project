import 'package:dio/dio.dart';
import '../models/create_development_plan_technology_dto.dart';
import '../models/development_plan_technology_dto.dart';

class DevelopmentPlanTechnologyRemoteSource {
  final Dio dio;

  DevelopmentPlanTechnologyRemoteSource(this.dio);

  Future<void> createDevelopmentPlanTechnology(CreateDevelopmentPlanTechnologyDto dto) async {
    await dio.post('/development-plan-technologies', data: dto.toJson());
  }

  Future<List<DevelopmentPlanTechnologyDto>> getAllDevelopmentPlanTechnologies() async {
    final response = await dio.get('/development-plan-technologies');
    return (response.data as List)
        .map((json) => DevelopmentPlanTechnologyDto.fromJson(json))
        .toList();
  }

  Future<void> updateDevelopmentPlanTechnology(String id, CreateDevelopmentPlanTechnologyDto dto) async {
    await dio.put('/development-plan-technologies/$id', data: dto.toJson());
  }

  Future<void> deleteDevelopmentPlanTechnology(String id) async {
    await dio.delete('/development-plan-technologies/$id');
  }
}
