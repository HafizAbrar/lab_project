import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/auth_providers.dart';
import '../../data/repositories/plan_features_repository_impl.dart';
import '../../data/sources/plan_feature_remote_source.dart';
import '../../domain/repositories/plan_features_repository.dart';

// Remote Source Provider
final planFeatureRemoteSourceProvider = Provider<PlanFeatureRemoteSource>(
      (ref) => PlanFeatureRemoteSource(ref.read(dioProvider)),
);

// Repository Provider
final planFeaturesRepositoryProvider = Provider<PlanFeaturesRepository>(
      (ref) => PlanFeaturesRepositoryImpl(
    PlanFeatureRemoteSource(ref.read(dioProvider)),
  ),
);

