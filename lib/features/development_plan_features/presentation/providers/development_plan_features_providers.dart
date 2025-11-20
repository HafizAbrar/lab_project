import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/auth_providers.dart';
import '../../data/repositories/development_plan_features_repository_impl.dart';
import '../../data/sources/development_plan_feature_remote_source.dart';
import '../../domain/repositories/development_plan_features_repository.dart';

// Remote Source Provider
final developmentPlanFeatureRemoteSourceProvider = Provider<DevelopmentPlanFeatureRemoteSource>(
      (ref) => DevelopmentPlanFeatureRemoteSource(ref.read(dioProvider)),
);

// Repository Provider
final developmentPlanFeaturesRepositoryProvider = Provider<DevelopmentPlanFeaturesRepository>(
      (ref) => DevelopmentPlanFeaturesRepositoryImpl(
    DevelopmentPlanFeatureRemoteSource(ref.read(dioProvider)),
  ),
);
