import 'package:dio/dio.dart';
import '../models/development_plan_dto.dart';
import '../models/create_development_plan_dto.dart';

class DevelopmentPlanRemoteSource {
  final Dio dio;

  DevelopmentPlanRemoteSource(this.dio);

  Future<List<DevelopmentPlanDto>> getAllDevelopmentPlans() async {
    final response = await dio.get('/development-plans');
    return (response.data as List)
        .map((json) => DevelopmentPlanDto.fromJson(json))
        .toList();
  }

  Future<void> createDevelopmentPlan(CreateDevelopmentPlanDto dto) async {
    await dio.post('/development-plans', data: dto.toJson());
  }

  Future<void> updateDevelopmentPlan(String id, CreateDevelopmentPlanDto dto) async {
    await dio.put('/development-plans/$id', data: dto.toJson());
  }

  Future<void> deleteDevelopmentPlan(String id) async {
    await dio.delete('/development-plans/$id');
  }
}
