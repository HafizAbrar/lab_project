import '../../domain/repositories/development_plan_features_repository.dart';
import '../models/create_development_plan_feature_dto.dart';
import '../models/development_plan_feature_dto.dart';
import '../sources/development_plan_feature_remote_source.dart';

class DevelopmentPlanFeaturesRepositoryImpl implements DevelopmentPlanFeaturesRepository {
  final DevelopmentPlanFeatureRemoteSource remoteSource;

  DevelopmentPlanFeaturesRepositoryImpl(this.remoteSource);

  @override
  Future<List<DevelopmentPlanFeatureDto>> getAllDevelopmentPlanFeatures() {
    return remoteSource.getAllDevelopmentPlanFeatures();
  }

  @override
  Future<void> createDevelopmentPlanFeature(CreateDevelopmentPlanFeatureDto dto) {
    return remoteSource.createDevelopmentPlanFeature(dto);
  }

  @override
  Future<void> updateDevelopmentPlanFeature(String id, CreateDevelopmentPlanFeatureDto dto) {
    return remoteSource.updateDevelopmentPlanFeature(id, dto);
  }

  @override
  Future<void> deleteDevelopmentPlanFeature(String id) {
    return remoteSource.deleteDevelopmentPlanFeature(id);
  }
}
