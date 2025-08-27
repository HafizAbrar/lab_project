import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lab_app/core/network/dio_client.dart';
import 'package:dio/dio.dart';

import '../../data/models/role_dto.dart';
import '../../data/repositories/roles_repository_impl.dart';
import '../../data/sources/roles_remote_source.dart';
import '../../domain/repositories/roles_repository.dart';

// Secure storage provider
final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage();
});

// Dio provider using DioClient with AuthInterceptor
final dioProvider = Provider<Dio>((ref) {
  final storage = ref.read(secureStorageProvider);
  final client = DioClient(storage);
  return client.build();
});

// Remote source provider
final rolesRemoteSourceProvider =
Provider((ref) => RolesRemoteSource(ref.read(dioProvider)));

// Repository provider
final rolesRepositoryProvider = Provider<RolesRepository>(
      (ref) => RolesRepositoryImpl(ref.read(rolesRemoteSourceProvider)),
);

// Roles list provider
final rolesListProvider = FutureProvider<List<RoleDto>>((ref) async {
  final repo = ref.read(rolesRepositoryProvider);
  return repo.getRoles();
});
