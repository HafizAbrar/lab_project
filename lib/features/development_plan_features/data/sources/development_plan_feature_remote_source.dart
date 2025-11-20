import 'package:dio/dio.dart';
import '../models/development_plan_feature_dto.dart';
import '../models/create_development_plan_feature_dto.dart';

class DevelopmentPlanFeatureRemoteSource {
  final Dio dio;

  DevelopmentPlanFeatureRemoteSource(this.dio);

  Future<List<DevelopmentPlanFeatureDto>> getAllDevelopmentPlanFeatures() async {
    final response = await dio.get('/development-plan-features');
    return (response.data as List)
        .map((json) => DevelopmentPlanFeatureDto.fromJson(json))
        .toList();
  }

  Future<void> createDevelopmentPlanFeature(CreateDevelopmentPlanFeatureDto dto) async {
    await dio.post('/development-plan-features', data: dto.toJson());
  }

  Future<void> updateDevelopmentPlanFeature(String id, CreateDevelopmentPlanFeatureDto dto) async {
    await dio.put('/development-plan-features/$id', data: dto.toJson());
  }

  Future<void> deleteDevelopmentPlanFeature(String id) async {
    await dio.delete('/development-plan-features/$id');
  }
}
