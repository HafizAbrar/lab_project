import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../data/repositories/blog_posts_repository_impl.dart';
import '../../data/sources/blog_post_remote_source.dart';
import '../../domain/repositories/blog_posts_repository.dart';

// Remote Source Provider
final blogPostRemoteSourceProvider = Provider<BlogPostRemoteSource>(
      (ref) => BlogPostRemoteSource(ref.read(dioProvider)),
);

// Repository Provider
final blogPostsRepositoryProvider = Provider<BlogPostsRepository>(
      (ref) => BlogPostsRepositoryImpl(
    BlogPostRemoteSource(ref.read(dioProvider)),
  ),
);
