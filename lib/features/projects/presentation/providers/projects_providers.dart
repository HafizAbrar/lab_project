// lib/features/projects/presentation/providers/projects_providers.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lab_app/features/roles/presentation/providers/roles_providers.dart';
import '../../data/models/project_dto.dart';
import '../../data/models/create_project_dto.dart';
import '../../data/sources/projects_remote_source.dart';
import '../../data/repositories/projects_repository_impl.dart';
import '../../domain/repositories/projects_repository.dart';

/// Remote source provider
final projectsRemoteSourceProvider = Provider<ProjectsRemoteSource>(
      (ref) => ProjectsRemoteSource(ref.read(dioProvider)),
);

/// Repository provider
final projectsRepositoryProvider = Provider<ProjectsRepository>(
      (ref) => ProjectsRepositoryImpl(ref.read(projectsRemoteSourceProvider)),
);

/// StateNotifier for managing projects state (list, create, update, delete)
class ProjectsNotifier extends StateNotifier<AsyncValue<List<ProjectDto>>> {
  final ProjectsRepository _repository;

  ProjectsNotifier(this._repository) : super(const AsyncLoading()) {
    fetchProjects();
  }

  /// Fetch all projects
  Future<void> fetchProjects() async {
    try {
      state = const AsyncLoading();
      final projects = await _repository.getAllProjects();
      state = AsyncData(projects);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  /// Create new project
  Future<void> createProject(CreateProjectDto dto) async {
    try {
      state = const AsyncLoading();
      await _repository.createProject(dto);
      await fetchProjects(); // refresh list after creation
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }


  /// Update existing project
  Future<void> updateProject(String id, CreateProjectDto dto) async {
    try {
      await _repository.updateProject(id, dto);
      await fetchProjects();
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  /// Delete project
  Future<void> deleteProject(String id) async {
    try {
      await _repository.deleteProject(id);
      await fetchProjects();
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

/// Provider for accessing the projects state and actions
final projectsProvider = StateNotifierProvider<ProjectsNotifier, AsyncValue<List<ProjectDto>>>(
      (ref) => ProjectsNotifier(ref.read(projectsRepositoryProvider)),
);
