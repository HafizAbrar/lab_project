import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/auth_providers.dart';
import '../../data/repositories/development_plan_technologies_repository_impl.dart';
import '../../data/sources/development_plan_technology_remote_source.dart';
import '../../domain/repositories/development_plan_technologies_repository.dart';

// Remote Source Provider
final developmentPlanTechnologyRemoteSourceProvider =
Provider<DevelopmentPlanTechnologyRemoteSource>(
      (ref) => DevelopmentPlanTechnologyRemoteSource(ref.read(dioProvider)),
);

// Repository Provider
final developmentPlanTechnologiesRepositoryProvider =
Provider<DevelopmentPlanTechnologiesRepository>(
      (ref) => DevelopmentPlanTechnologiesRepositoryImpl(
    DevelopmentPlanTechnologyRemoteSource(ref.read(dioProvider)),
  ),
);
