// lib/features/project_milestones/presentation/providers/project_milestones_providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lab_app/features/roles/presentation/providers/roles_providers.dart';

import '../../data/sources/project_milestones_remote_source.dart';
import '../../data/repositories/project_milestones_repository_impl.dart';
import '../../domain/repositories/project_milestones_repository.dart';

// Remote source provider
final projectMilestonesRemoteSourceProvider = Provider<ProjectMilestonesRemoteSource>(
      (ref) => ProjectMilestonesRemoteSource(ref.read(dioProvider)),
);

// Repository provider
final projectMilestonesRepositoryProvider = Provider<ProjectMilestonesRepository>(
      (ref) => ProjectMilestonesRepositoryImpl(
    ref.read(projectMilestonesRemoteSourceProvider),
  ),
);
