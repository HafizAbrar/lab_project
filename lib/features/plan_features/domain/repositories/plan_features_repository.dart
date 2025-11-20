import '../../data/models/create_plan_feature_dto.dart';
import '../../data/models/plan_feature_dto.dart';

abstract class PlanFeaturesRepository {
  Future<List<PlanFeatureDto>> getAllPlanFeatures();
  Future<void> createPlanFeature(CreatePlanFeatureDto dto);
  Future<void> updatePlanFeature(String id, CreatePlanFeatureDto dto);
  Future<void> deletePlanFeature(String id);
}
