import '../../domain/repositories/blog_comments_repository.dart';
import '../models/create_blog_comment_dto.dart';
import '../models/blog_comment_dto.dart';
import '../sources/blog_comment_remote_source.dart';

class BlogCommentsRepositoryImpl implements BlogCommentsRepository {
  final BlogCommentRemoteSource remoteSource;

  BlogCommentsRepositoryImpl(this.remoteSource);

  @override
  Future<void> createBlogComment(CreateBlogCommentDto dto) =>
      remoteSource.createBlogComment(dto);

  @override
  Future<List<BlogCommentDto>> getCommentsByPostId(String postId) =>
      remoteSource.getCommentsByPostId(postId);

  @override
  Future<void> updateBlogComment(String id, CreateBlogCommentDto dto) =>
      remoteSource.updateBlogComment(id, dto);

  @override
  Future<void> deleteBlogComment(String id) =>
      remoteSource.deleteBlogComment(id);

  @override
  Future<void> approveBlogComment(String id, bool approve) =>
      remoteSource.approveBlogComment(id, approve);
}
