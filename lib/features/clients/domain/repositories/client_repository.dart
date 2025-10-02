// lib/features/clients/domain/repositories/client_repository.dart

import 'dart:io';
import '../../data/models/clients_dto.dart';
import '../../data/models/client_profile_dto.dart';
import '../../data/models/create_client_profile_dto.dart';
import '../../data/models/update_client_profile_dto.dart';

abstract class ClientRepository {
  Future<List<ClientDto>> getClients();
  Future<List<ClientProfileDto>> getClientProfiles();
  Future<ClientProfileDto> getClientProfile(String id);

  Future<ClientProfileDto> createClientProfile(CreateClientProfileDto dto, { File? file });

  /// Now accepts optional named file parameter to update both fields and photo
  Future<ClientProfileDto> updateClientProfile(String id, UpdateClientProfileDto dto, { File? file });

  Future<ClientProfileDto> updateClientProfileImage(String id, File file);
  Future<void> deleteClientProfile(String id);
}
