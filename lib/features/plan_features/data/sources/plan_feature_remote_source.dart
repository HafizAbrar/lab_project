import 'package:dio/dio.dart';
import '../models/plan_feature_dto.dart';
import '../models/create_plan_feature_dto.dart';

class PlanFeatureRemoteSource {
  final Dio dio;

  PlanFeatureRemoteSource(this.dio);

  Future<List<PlanFeatureDto>> getAllPlanFeatures() async {
    final response = await dio.get('/plan-features');
    return (response.data as List)
        .map((json) => PlanFeatureDto.fromJson(json))
        .toList();
  }

  Future<void> createPlanFeature(CreatePlanFeatureDto dto) async {
    await dio.post('/plan-features', data: dto.toJson());
  }

  Future<void> updatePlanFeature(String id, CreatePlanFeatureDto dto) async {
    await dio.put('/plan-features/$id', data: dto.toJson());
  }

  Future<void> deletePlanFeature(String id) async {
    await dio.delete('/plan-features/$id');
  }
}
