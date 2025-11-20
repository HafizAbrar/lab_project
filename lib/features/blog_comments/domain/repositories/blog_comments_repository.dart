import '../../data/models/create_blog_comment_dto.dart';
import '../../data/models/blog_comment_dto.dart';

abstract class BlogCommentsRepository {
  Future<void> createBlogComment(CreateBlogCommentDto dto);
  Future<List<BlogCommentDto>> getCommentsByPostId(String postId);
  Future<void> updateBlogComment(String id, CreateBlogCommentDto dto);
  Future<void> deleteBlogComment(String id);
  Future<void> approveBlogComment(String id, bool approve);
}
