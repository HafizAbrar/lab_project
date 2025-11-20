import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../data/repositories/blog_comments_repository_impl.dart';
import '../../data/sources/blog_comment_remote_source.dart';
import '../../domain/repositories/blog_comments_repository.dart';

// Remote Source Provider
final blogCommentRemoteSourceProvider = Provider<BlogCommentRemoteSource>(
      (ref) => BlogCommentRemoteSource(ref.read(dioProvider)),
);

// Repository Provider
final blogCommentsRepositoryProvider = Provider<BlogCommentsRepository>(
      (ref) => BlogCommentsRepositoryImpl(
    BlogCommentRemoteSource(ref.read(dioProvider)),
  ),
);
