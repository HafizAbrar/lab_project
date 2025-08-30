import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../core/network/dio_client.dart';
import '../../data/modals/permission_dto.dart';
import '../../data/repositories/permission_repository_impl.dart';
import '../../data/sources/permission_remote_source.dart';
import '../../domain/repositories/permission_repository.dart';


// Secure storage provider (already exists in your project)
final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage();
});

// Dio provider
final dioProvider = Provider<Dio>((ref) {
  final storage = ref.read(secureStorageProvider);
  final client = DioClient(storage);
  return client.build();
});

// Remote source
final permissionsRemoteSourceProvider =
Provider((ref) => PermissionsRemoteSource(ref.read(dioProvider)));

// Repository
final permissionsRepositoryProvider = Provider<PermissionsRepository>(
      (ref) => PermissionsRepositoryImpl(ref.read(permissionsRemoteSourceProvider)),
);

// Permissions list provider
final permissionsListProvider = FutureProvider<List<PermissionDto>>((ref) async {
  final repo = ref.read(permissionsRepositoryProvider);
  return repo.getPermissions();
});
