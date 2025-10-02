import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lab_app/features/clients/data/models/update_client_profile_dto.dart';

import '../../../../core/network/dio_client.dart';
import '../../data/models/clients_dto.dart';
import '../../data/models/client_profile_dto.dart';
import '../../data/models/create_client_profile_dto.dart';
import '../../data/repositories/client_repository_impl.dart';
import '../../data/sources/client_remote_source.dart';
import '../../domain/repositories/client_repository.dart';

/// 🔐 Secure storage provider
final clientSecureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage();
});

/// 🌐 Dio client provider
final clientDioProvider = Provider<Dio>((ref) {
  final storage = ref.read(clientSecureStorageProvider);
  final client = DioClient(storage);
  return client.build();
});

/// 📡 Remote source provider
final clientRemoteSourceProvider = Provider<ClientRemoteSource>((ref) {
  final dio = ref.read(clientDioProvider);
  return ClientRemoteSource(dio);
});

/// 🏗 Repository provider
final clientRepositoryProvider = Provider<ClientRepository>((ref) {
  final remoteSource = ref.read(clientRemoteSourceProvider);
  return ClientRepositoryImpl(remoteSource);
});

/// 👥 Clients (users with role=client)
final clientsListProvider = FutureProvider<List<ClientDto>>((ref) async {
  final repo = ref.read(clientRepositoryProvider);
  return repo.getClients();
});

/// 📋 Client profiles list
final clientProfilesProvider =
FutureProvider<List<ClientProfileDto>>((ref) async {
  final repo = ref.read(clientRepositoryProvider);
  return repo.getClientProfiles();
});

/// ➕ Create new client profile params holder
class CreateClientProfileParams {
  final CreateClientProfileDto dto;
  final File? file;
  CreateClientProfileParams(this.dto, this.file);
}

/// ➕ Create new client profile provider
final createClientProfileProvider =
FutureProvider.family<ClientProfileDto, CreateClientProfileParams>(
        (ref, params) async {
      final repo = ref.read(clientRepositoryProvider);
      return repo.createClientProfile(params.dto, file: params.file);
    });

/// 🔹 Update Client Profile (all fields + profile photo at once)
class UpdateClientProfileParams {
  final String profileId;
  final UpdateClientProfileDto dto;
  final File? file;

  UpdateClientProfileParams({
    required this.profileId,
    required this.dto,
    this.file,
  });
}

final updateClientProfileProvider =
FutureProvider.family<ClientProfileDto, UpdateClientProfileParams>(
        (ref, params) async {
      final repo = ref.read(clientRepositoryProvider);
      return repo.updateClientProfile(
        params.profileId,
        params.dto,
        file: params.file,
      );
    });

/// 🔹 Get a single client profile by ID
final clientProfileProvider =
FutureProvider.family<ClientProfileDto, String>((ref, id) async {
  final repo = ref.read(clientRepositoryProvider);
  return repo.getClientProfile(id);
});

/// 🗑 Delete client profile
final deleteClientProfileProvider =
FutureProvider.family<void, String>((ref, id) async {
  final repo = ref.read(clientRepositoryProvider);
  await repo.deleteClientProfile(id);
});
