import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../features/auth/presentation/providers/auth_providers.dart';
import '../../data/repositories/admin_repository_impl.dart';
import '../../data/sources/admin_remote_source.dart';
import '../../data/models/admin_stats.dart';

final adminDioProvider = Provider<Dio>((ref) {
  // Use the same dio (with tokens)
  return ref.watch(dioProvider);
});

final adminRemoteProvider = Provider((ref) => AdminRemoteSource(ref.watch(adminDioProvider)));
final adminRepoProvider = Provider<AdminRepository>((ref) => AdminRepositoryImpl(ref.watch(adminRemoteProvider)));

final adminStatsProvider = FutureProvider<AdminStats>((ref) async {
  return ref.watch(adminRepoProvider).getStats();
});

final adminUsersProvider = FutureProvider.family<List<Map<String, dynamic>>, int>((ref, page) async {
  return ref.watch(adminRepoProvider).getUsers(page: page);
});
