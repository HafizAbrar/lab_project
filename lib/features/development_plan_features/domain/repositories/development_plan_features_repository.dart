import '../../data/models/create_development_plan_feature_dto.dart';
import '../../data/models/development_plan_feature_dto.dart';

abstract class DevelopmentPlanFeaturesRepository {
  Future<List<DevelopmentPlanFeatureDto>> getAllDevelopmentPlanFeatures();
  Future<void> createDevelopmentPlanFeature(CreateDevelopmentPlanFeatureDto dto);
  Future<void> updateDevelopmentPlanFeature(String id, CreateDevelopmentPlanFeatureDto dto);
  Future<void> deleteDevelopmentPlanFeature(String id);
}
