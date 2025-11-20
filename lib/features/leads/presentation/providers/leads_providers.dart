import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../data/sources/lead_remote_source.dart';
import '../../data/repositories/leads_repository_impl.dart';
import '../../domain/repositories/leads_repository.dart';

// Remote Source Provider
final leadRemoteSourceProvider = Provider<LeadRemoteSource>(
      (ref) => LeadRemoteSource(ref.read(dioProvider)),
);

// Repository Provider
final leadsRepositoryProvider = Provider<LeadsRepository>(
      (ref) => LeadsRepositoryImpl(ref.read(leadRemoteSourceProvider)),
);
