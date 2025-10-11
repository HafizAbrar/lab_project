// lib/data/repositories/categories_repository_impl.dart
import '../../domain/repositories/categories_repository.dart';
import '../models/category_dto.dart';
import '../models/create_category_dto.dart';
import '../sources/category_remote_source.dart';

class CategoriesRepositoryImpl implements CategoriesRepository {
  final CategoryRemoteSource remoteSource;

  CategoriesRepositoryImpl(this.remoteSource);

  @override
  Future<void> createCategory(CreateCategoryDto dto) {
    return remoteSource.createCategory(dto);
  }

  @override
  Future<void> updateCategory(String categoryId, CreateCategoryDto dto) {
    return remoteSource.updateCategory(categoryId, dto);
  }

  @override
  Future<void> deleteCategory(String categoryId) {
    return remoteSource.deleteCategory(categoryId);
  }

  @override
  Future<List<CategoryDto>> getAllCategories() {
    return remoteSource.getAllCategories();
  }
}
