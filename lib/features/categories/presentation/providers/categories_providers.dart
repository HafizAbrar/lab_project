import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lab_app/features/roles/presentation/providers/roles_providers.dart';

import '../../data/models/create_category_dto.dart';
import '../../data/models/category_dto.dart';
import '../../data/repositories/categories_repository_impl.dart';
import '../../data/sources/category_remote_source.dart';
import '../../domain/repositories/categories_repository.dart';

// Remote source provider
final categoryRemoteSourceProvider = Provider<CategoryRemoteSource>(
      (ref) => CategoryRemoteSource(ref.read(dioProvider)),
);
// Repository provider
final categoryRepositoryProvider = Provider<CategoriesRepository>(
      (ref) => CategoriesRepositoryImpl(
    CategoryRemoteSource(ref.read(dioProvider)),
  ),
);
// Create Category provider
final createCategoryProvider =
FutureProvider.family<void, CreateCategoryDto>((ref, dto) async {
  final remoteSource = ref.read(categoryRemoteSourceProvider);
  await remoteSource.createCategory(dto);
});

// Update Category provider
final updateCategoryProvider =
FutureProvider.family<void, Map<String, dynamic>>((ref, params) async {
  final remoteSource = ref.read(categoryRemoteSourceProvider);
  final dto = params['dto'] as CreateCategoryDto;
  final categoryId = params['categoryId'] as String;

  await remoteSource.updateCategory(categoryId, dto);
});

// Delete Category provider
final deleteCategoryProvider =
FutureProvider.family<void, String>((ref, categoryId) async {
  final remoteSource = ref.read(categoryRemoteSourceProvider);
  await remoteSource.deleteCategory(categoryId);
});

// Get all Categories provider
final getAllCategoriesProvider =
FutureProvider<List<CategoryDto>>((ref) async {
  final remoteSource = ref.read(categoryRemoteSourceProvider);
  return remoteSource.getAllCategories();
});
