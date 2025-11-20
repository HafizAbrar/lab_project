import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/auth_providers.dart';
import '../../data/repositories/development_plan_services_repository_impl.dart';
import '../../data/sources/development_plan_service_remote_source.dart';
import '../../domain/repositories/development_plan_services_repository.dart';

// Remote Source Provider
final developmentPlanServiceRemoteSourceProvider = Provider<DevelopmentPlanServiceRemoteSource>(
      (ref) => DevelopmentPlanServiceRemoteSource(ref.read(dioProvider)),
);

// Repository Provider
final developmentPlanServicesRepositoryProvider = Provider<DevelopmentPlanServicesRepository>(
      (ref) => DevelopmentPlanServicesRepositoryImpl(
    DevelopmentPlanServiceRemoteSource(ref.read(dioProvider)),
  ),
);
