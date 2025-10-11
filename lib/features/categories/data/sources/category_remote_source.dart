// lib/data/sources/category_remote_source.dart
import 'package:dio/dio.dart';
import '../models/category_dto.dart';
import '../models/create_category_dto.dart';

class CategoryRemoteSource {
  final Dio dio;

  CategoryRemoteSource(this.dio);

  // Create Category
  Future<void> createCategory(CreateCategoryDto dto) async {
    await dio.post('/categories', data: dto.toJson());
  }

  // Update Category
  Future<void> updateCategory(String categoryId, CreateCategoryDto dto) async {
    await dio.patch('/categories/$categoryId', data: dto.toJson());
  }

  // Delete Category
  Future<void> deleteCategory(String categoryId) async {
    await dio.delete('/categories/$categoryId');
  }

  // Get All Categories
  Future<List<CategoryDto>> getAllCategories() async {
    final response = await dio.get('/categories');
    final data = response.data;

    if (data is List) {
      // Case: response is a plain list of categories
      return data.map((e) => CategoryDto.fromJson(e)).toList();
    } else if (data is Map && data['data'] is List) {
      // Case: response is wrapped in a 'data' field
      return (data['data'] as List)
          .map((e) => CategoryDto.fromJson(e))
          .toList();
    } else {
      throw Exception('Unexpected response format: $data');
    }
  }
}
