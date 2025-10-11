import '../../data/models/category_dto.dart';
import '../../data/models/create_category_dto.dart';

abstract class CategoriesRepository {
  /// Create a new category
  Future<void> createCategory(CreateCategoryDto dto);

  /// Update an existing category by its ID
  Future<void> updateCategory(String categoryId, CreateCategoryDto dto);

  /// Delete a category by its ID
  Future<void> deleteCategory(String categoryId);

  /// Fetch all categories
  Future<List<CategoryDto>> getAllCategories();
}
