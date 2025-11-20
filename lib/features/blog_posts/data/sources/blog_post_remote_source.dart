import 'package:dio/dio.dart';
import '../models/create_blog_post_dto.dart';
import '../models/blog_post_dto.dart';

class BlogPostRemoteSource {
  final Dio dio;

  BlogPostRemoteSource(this.dio);

  Future<void> createBlogPost(CreateBlogPostDto dto) async {
    await dio.post('/blog-posts', data: dto.toJson());
  }

  Future<List<BlogPostDto>> getAllBlogPosts() async {
    final response = await dio.get('/blog-posts');
    return (response.data as List)
        .map((json) => BlogPostDto.fromJson(json))
        .toList();
  }

  Future<BlogPostDto> getBlogPostById(String id) async {
    final response = await dio.get('/blog-posts/$id');
    return BlogPostDto.fromJson(response.data);
  }

  Future<void> updateBlogPost(String id, CreateBlogPostDto dto) async {
    await dio.put('/blog-posts/$id', data: dto.toJson());
  }

  Future<void> deleteBlogPost(String id) async {
    await dio.delete('/blog-posts/$id');
  }
}
