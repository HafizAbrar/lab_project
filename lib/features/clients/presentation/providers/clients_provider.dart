// import 'dart:io';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
//
// import '../../../../core/network/dio_client.dart';
//
// /// 🔐 Secure storage provider
// final clientSecureStorageProvider = Provider<FlutterSecureStorage>((ref) {
//   return const FlutterSecureStorage();
// });
//
// /// 🌐 Dio client provider
// final clientDioProvider = Provider<Dio>((ref) {
//   final storage = ref.read(clientSecureStorageProvider);
//   final client = DioClient(storage);
//   return client.build();
// });
//
// /// 📡 Remote source provider
// final clientRemoteSourceProvider =
// Provider<ClientProfilesRemoteSource>((ref) {
//   final dio = ref.read(clientDioProvider);
//   return ClientProfilesRemoteSource(dio);
// });
//
// /// 🏗 Repository provider
// final clientRepositoryProvider =
// Provider<ClientProfilesRepository>((ref) {
//   final remoteSource = ref.read(clientRemoteSourceProvider);
//   return ClientProfilesRepositoryImpl(remoteSource);
// });
//
// /// 👥 Clients list
// final clientsListProvider = FutureProvider<List<ClientDto>>((ref) async {
//   final repo = ref.read(clientRepositoryProvider);
//   return repo.getClients();
// });
//
// /// 📋 Client profiles list
// final clientProfilesProvider =
// FutureProvider<List<ClientProfileDto>>((ref) async {
//   final repo = ref.read(clientRepositoryProvider);
//   return repo.getClientProfiles();
// });
//
// /// ➕ Create new client profile params holder
// class CreateClientProfileParams {
//   final CreateClientProfileDto dto;
//   final File? file;
//   CreateClientProfileParams(this.dto, this.file);
// }
//
// /// ➕ Create new client profile provider
// final createClientProfileProvider = FutureProvider.family<
//     ClientProfileDto, CreateClientProfileParams>((ref, params) async {
//   final repo = ref.read(clientRepositoryProvider);
//   return repo.createClientProfile(params.dto, file: params.file);
// });
//
// /// 🔹 Update Client Profile (fields only, no image)
// final updateClientProfileProvider = FutureProvider.family<
//     ClientProfileDto, Map<String, dynamic>>((ref, params) async {
//   final repo = ref.read(clientRepositoryProvider);
//   final profileId = params['profileId'] as String;
//   final dto = params['dto'] as UpdateClientProfileDto;
//
//   return repo.updateClientProfile(profileId, dto);
// });
//
// /// 🔹 Update Client Profile Image (separate route)
// final updateClientProfileImageProvider = FutureProvider.family<
//     ClientProfileDto, Map<String, dynamic>>((ref, params) async {
//   final repo = ref.read(clientRepositoryProvider);
//   final profileId = params['profileId'] as String;
//   final file = params['file'] as File;
//
//   return repo.updateClientProfileImage(profileId, file);
// });
//
// /// 🗑 Delete client profile
// final deleteClientProfileProvider =
// FutureProvider.family<void, String>((ref, id) async {
//   final repo = ref.read(clientRepositoryProvider);
//   await repo.deleteClientProfile(id);
// });
