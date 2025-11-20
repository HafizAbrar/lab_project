// lib/features/project_updates/presentation/providers/project_updates_providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lab_app/features/roles/presentation/providers/roles_providers.dart';

import '../../data/sources/project_updates_remote_source.dart';
import '../../data/repositories/project_updates_repository_impl.dart';
import '../../domain/repositories/project_updates_repository.dart';

// Remote Source Provider
final projectUpdatesRemoteSourceProvider = Provider<ProjectUpdatesRemoteSource>(
      (ref) => ProjectUpdatesRemoteSource(ref.read(dioProvider)),
);

// Repository Provider
final projectUpdatesRepositoryProvider = Provider<ProjectUpdatesRepository>(
      (ref) => ProjectUpdatesRepositoryImpl(
    ref.read(projectUpdatesRemoteSourceProvider),
  ),
);
