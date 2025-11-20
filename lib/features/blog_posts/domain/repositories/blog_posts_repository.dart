import '../../data/models/create_blog_post_dto.dart';
import '../../data/models/blog_post_dto.dart';

abstract class BlogPostsRepository {
  Future<void> createBlogPost(CreateBlogPostDto dto);
  Future<List<BlogPostDto>> getAllBlogPosts();
  Future<BlogPostDto> getBlogPostById(String id);
  Future<void> updateBlogPost(String id, CreateBlogPostDto dto);
  Future<void> deleteBlogPost(String id);
}
