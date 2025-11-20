import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../data/sources/client_interaction_remote_source.dart';
import '../../data/repositories/client_interactions_repository_impl.dart';
import '../../domain/repositories/client_interactions_repository.dart';

// Remote Source Provider
final clientInteractionRemoteSourceProvider = Provider<ClientInteractionRemoteSource>(
      (ref) => ClientInteractionRemoteSource(ref.read(dioProvider)),
);

// Repository Provider
final clientInteractionsRepositoryProvider = Provider<ClientInteractionsRepository>(
      (ref) => ClientInteractionsRepositoryImpl(ref.read(clientInteractionRemoteSourceProvider)),
);
