import '../../domain/repositories/blog_posts_repository.dart';
import '../models/create_blog_post_dto.dart';
import '../models/blog_post_dto.dart';
import '../sources/blog_post_remote_source.dart';

class BlogPostsRepositoryImpl implements BlogPostsRepository {
  final BlogPostRemoteSource remoteSource;

  BlogPostsRepositoryImpl(this.remoteSource);

  @override
  Future<void> createBlogPost(CreateBlogPostDto dto) =>
      remoteSource.createBlogPost(dto);

  @override
  Future<List<BlogPostDto>> getAllBlogPosts() =>
      remoteSource.getAllBlogPosts();

  @override
  Future<BlogPostDto> getBlogPostById(String id) =>
      remoteSource.getBlogPostById(id);

  @override
  Future<void> updateBlogPost(String id, CreateBlogPostDto dto) =>
      remoteSource.updateBlogPost(id, dto);

  @override
  Future<void> deleteBlogPost(String id) =>
      remoteSource.deleteBlogPost(id);
}
