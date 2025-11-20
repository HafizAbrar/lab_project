import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/auth_providers.dart';
import '../../data/models/create_development_plan_dto.dart';
import '../../data/models/development_plan_dto.dart';
import '../../data/repositories/development_plans_repository_impl.dart';
import '../../data/sources/development_plan_remote_source.dart';
import '../../domain/repositories/development_plans_repository.dart';

// Remote Source Provider
final developmentPlanRemoteSourceProvider = Provider<DevelopmentPlanRemoteSource>(
      (ref) => DevelopmentPlanRemoteSource(ref.read(dioProvider)),
);

// Repository Provider
final developmentPlansRepositoryProvider = Provider<DevelopmentPlansRepository>(
      (ref) => DevelopmentPlansRepositoryImpl(
    DevelopmentPlanRemoteSource(ref.read(dioProvider)),
  ),
);

// (Optional) Example: use this if you want a list provider directly
// final developmentPlansListProvider = FutureProvider<List<DevelopmentPlanDto>>((ref) async {
//   final repo = ref.watch(developmentPlansRepositoryProvider);
//   return repo.getAllDevelopmentPlans();
// });
