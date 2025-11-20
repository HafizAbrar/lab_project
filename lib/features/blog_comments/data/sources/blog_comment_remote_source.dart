import 'package:dio/dio.dart';
import '../models/create_blog_comment_dto.dart';
import '../models/blog_comment_dto.dart';

class BlogCommentRemoteSource {
  final Dio dio;

  BlogCommentRemoteSource(this.dio);

  Future<void> createBlogComment(CreateBlogCommentDto dto) async {
    await dio.post('/blog-comments', data: dto.toJson());
  }

  Future<List<BlogCommentDto>> getCommentsByPostId(String postId) async {
    final response = await dio.get('/blog-comments/post/$postId');
    return (response.data as List)
        .map((json) => BlogCommentDto.fromJson(json))
        .toList();
  }

  Future<void> updateBlogComment(String id, CreateBlogCommentDto dto) async {
    await dio.put('/blog-comments/$id', data: dto.toJson());
  }

  Future<void> deleteBlogComment(String id) async {
    await dio.delete('/blog-comments/$id');
  }

  Future<void> approveBlogComment(String id, bool approve) async {
    await dio.patch('/blog-comments/$id/approve', data: {'isApproved': approve});
  }
}
