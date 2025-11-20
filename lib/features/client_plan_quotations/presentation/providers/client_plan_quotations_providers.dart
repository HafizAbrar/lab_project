import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/auth_providers.dart';
import '../../data/repositories/client_plan_quotations_repository_impl.dart';
import '../../data/sources/client_plan_quotation_remote_source.dart';
import '../../domain/repositories/client_plan_quotations_repository.dart';

// Remote Source Provider
final clientPlanQuotationRemoteSourceProvider = Provider<ClientPlanQuotationRemoteSource>(
      (ref) => ClientPlanQuotationRemoteSource(ref.read(dioProvider)),
);

// Repository Provider
final clientPlanQuotationsRepositoryProvider = Provider<ClientPlanQuotationsRepository>(
      (ref) => ClientPlanQuotationsRepositoryImpl(
    ClientPlanQuotationRemoteSource(ref.read(dioProvider)),
  ),
);
