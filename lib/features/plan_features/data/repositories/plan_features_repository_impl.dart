import '../../domain/repositories/plan_features_repository.dart';
import '../models/create_plan_feature_dto.dart';
import '../models/plan_feature_dto.dart';
import '../sources/plan_feature_remote_source.dart';

class PlanFeaturesRepositoryImpl implements PlanFeaturesRepository {
  final PlanFeatureRemoteSource remoteSource;

  PlanFeaturesRepositoryImpl(this.remoteSource);

  @override
  Future<List<PlanFeatureDto>> getAllPlanFeatures() {
    return remoteSource.getAllPlanFeatures();
  }

  @override
  Future<void> createPlanFeature(CreatePlanFeatureDto dto) {
    return remoteSource.createPlanFeature(dto);
  }

  @override
  Future<void> updatePlanFeature(String id, CreatePlanFeatureDto dto) {
    return remoteSource.updatePlanFeature(id, dto);
  }

  @override
  Future<void> deletePlanFeature(String id) {
    return remoteSource.deletePlanFeature(id);
  }
}
