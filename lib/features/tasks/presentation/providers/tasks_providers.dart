import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lab_app/features/roles/presentation/providers/roles_providers.dart';

import '../../data/models/create_task_dto.dart';
import '../../data/models/task_dto.dart';
import '../../data/repositories/tasks_repository_impl.dart';
import '../../data/sources/task_remote_source.dart';
import '../../domain/repositories/tasks_repository.dart';

// Remote Source Provider
final taskRemoteSourceProvider = Provider<TaskRemoteSource>(
      (ref) => TaskRemoteSource(ref.read(dioProvider)),
);

// Repository Provider
final taskRepositoryProvider = Provider<TasksRepository>(
      (ref) => TasksRepositoryImpl(
    TaskRemoteSource(ref.read(dioProvider)),
  ),
);
