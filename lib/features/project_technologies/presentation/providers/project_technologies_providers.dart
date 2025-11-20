import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lab_app/features/roles/presentation/providers/roles_providers.dart';

import '../../data/models/create_project_technology_dto.dart';
import '../../data/models/project_technology_dto.dart';
import '../../data/repositories/project_technologies_repository_impl.dart';
import '../../data/sources/project_technology_remote_source.dart';
import '../../domain/repositories/project_technologies_repository.dart';

// Remote Source Provider
final projectTechnologyRemoteSourceProvider = Provider<ProjectTechnologyRemoteSource>(
      (ref) => ProjectTechnologyRemoteSource(ref.read(dioProvider)),
);

// Repository Provider
final projectTechnologiesRepositoryProvider = Provider<ProjectTechnologiesRepository>(
      (ref) => ProjectTechnologiesRepositoryImpl(
    ProjectTechnologyRemoteSource(ref.read(dioProvider)),
  ),
);
