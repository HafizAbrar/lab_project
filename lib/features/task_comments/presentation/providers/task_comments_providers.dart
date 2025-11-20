import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lab_app/features/roles/presentation/providers/roles_providers.dart';
import '../../data/repositories/task_comments_repository_impl.dart';
import '../../data/sources/task_comment_remote_source.dart';
import '../../domain/repositories/task_comments_repository.dart';

// Remote Source Provider
final taskCommentRemoteSourceProvider = Provider<TaskCommentRemoteSource>(
      (ref) => TaskCommentRemoteSource(ref.read(dioProvider)),
);

// Repository Provider
final taskCommentsRepositoryProvider = Provider<TaskCommentsRepository>(
      (ref) => TaskCommentsRepositoryImpl(
    TaskCommentRemoteSource(ref.read(dioProvider)),
  ),
);
