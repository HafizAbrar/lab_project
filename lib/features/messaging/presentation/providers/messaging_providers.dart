import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../data/sources/messaging_remote_source.dart';
import '../../data/repositories/messaging_repository_impl.dart';
import '../../domain/repositories/messaging_repository.dart';

// Remote source provider
final messagingRemoteSourceProvider = Provider<MessagingRemoteSource>(
      (ref) => MessagingRemoteSource(ref.read(dioProvider)),
);

// Repository provider
final messagingRepositoryProvider = Provider<MessagingRepository>(
      (ref) => MessagingRepositoryImpl(ref.read(messagingRemoteSourceProvider)),
);
