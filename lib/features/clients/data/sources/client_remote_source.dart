// lib/features/clients/data/sources/client_remote_source.dart
import 'dart:io';
import 'package:dio/dio.dart';

import '../models/clients_dto.dart';
import '../models/client_profile_dto.dart';
import '../models/create_client_profile_dto.dart';
import '../models/update_client_profile_dto.dart';

class ClientRemoteSource {
  final Dio dio;
  ClientRemoteSource(this.dio);

  Future<List<ClientDto>> getClients() async {
    final response = await dio.get('/users');
    final users = (response.data as Map<String, dynamic>)['data'] as List<dynamic>? ?? [];
    final clients = users.where((u) {
      final role = (u as Map<String, dynamic>)['role'] as Map<String, dynamic>? ?? {};
      return role['name'] == 'client';
    }).toList();
    return clients.map((e) => ClientDto.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<List<ClientProfileDto>> getClientProfiles() async {
    final response = await dio.get('/clients');
    final data = (response.data as Map<String, dynamic>)['data'] as List<dynamic>? ?? [];
    return data.map((e) => ClientProfileDto.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<ClientProfileDto> getClientProfile(String id) async {
    final response = await dio.get('/clients/$id');
    final data = (response.data as Map<String, dynamic>)['data'] as Map<String, dynamic>;
    return ClientProfileDto.fromJson(data);
  }

  Future<ClientProfileDto> createClientProfile(
      CreateClientProfileDto dto, {
        File? file,
        required String token,
      }) async {
    final formData = await dto.toFormData(file: file);

    try {
      final response = await dio.post(
        "/clients",
        data: formData,
        options: Options(
          headers: {"Authorization": "Bearer $token"}, // ✅ no manual content-type
        ),
      );

      final data = (response.data as Map<String, dynamic>)['data'] as Map<String, dynamic>;
      return ClientProfileDto.fromJson(data);
    } on DioException catch (e) {
      throw Exception("Create failed: ${e.response?.data ?? e.message}");
    }
  }

  Future<ClientProfileDto> updateClientProfile(
      String id,
      UpdateClientProfileDto dto, {
        File? file,
        required String token,
      }) async {
    final formData = await dto.toFormData(file: file);

    try {
      final response = await dio.patch(
        "/clients/$id",
        data: formData,
        options: Options(
          headers: {"Authorization": "Bearer $token"},
        ),
      );

      final data = (response.data as Map<String, dynamic>)['data'] as Map<String, dynamic>;
      return ClientProfileDto.fromJson(data);
    } on DioException catch (e) {
      throw Exception("Update failed: ${e.response?.data ?? e.message}");
    }
  }

  Future<ClientProfileDto> updateClientProfileImage(
      String id,
      File file, {
        required String token,
      }) async {
    final formData = FormData.fromMap({
      "profilePhoto": await MultipartFile.fromFile(
        file.path,
        filename: file.path.split('/').last,
      ),
    });

    try {
      final response = await dio.patch(
        "/clients/$id/photo",
        data: formData,
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      final data = (response.data as Map<String, dynamic>)['data'] as Map<String, dynamic>;
      return ClientProfileDto.fromJson(data);
    } on DioException catch (e) {
      throw Exception("Image update failed: ${e.response?.data ?? e.message}");
    }
  }

  Future<void> deleteClientProfile(String id, {required String token}) async {
    try {
      await dio.delete(
        '/clients/$id',
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
    } on DioException catch (e) {
      throw Exception("Delete failed: ${e.response?.data ?? e.message}");
    }
  }
}
