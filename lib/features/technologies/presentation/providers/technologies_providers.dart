// lib/features/technologies/presentation/providers/technologies_providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lab_app/features/roles/presentation/providers/roles_providers.dart';

import '../../data/sources/technologies_remote_source.dart';
import '../../data/repositories/technologies_repository_impl.dart';
import '../../domain/repositories/technologies_repository.dart';

// Remote source provider
final technologiesRemoteSourceProvider = Provider<TechnologiesRemoteSource>(
      (ref) => TechnologiesRemoteSource(ref.read(dioProvider)),
);

// Repository provider
final technologiesRepositoryProvider = Provider<TechnologiesRepository>(
      (ref) => TechnologiesRepositoryImpl(
    ref.read(technologiesRemoteSourceProvider),
  ),
);
