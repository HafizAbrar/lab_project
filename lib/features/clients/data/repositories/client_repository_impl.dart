// lib/features/clients/data/repositories/client_repository_impl.dart
import 'dart:io';

import '../sources/client_remote_source.dart';
import '../models/clients_dto.dart';
import '../models/client_profile_dto.dart';
import '../models/create_client_profile_dto.dart';
import '../models/update_client_profile_dto.dart';
import '../../domain/repositories/client_repository.dart';

class ClientRepositoryImpl implements ClientRepository {
  final ClientRemoteSource remoteSource;
  ClientRepositoryImpl(this.remoteSource);

  @override
  Future<List<ClientDto>> getClients() => remoteSource.getClients();

  @override
  Future<List<ClientProfileDto>> getClientProfiles() => remoteSource.getClientProfiles();

  @override
  Future<ClientProfileDto> getClientProfile(String id) => remoteSource.getClientProfile(id);

  @override
  Future<ClientProfileDto> createClientProfile(CreateClientProfileDto dto, {File? file}) =>
      remoteSource.createClientProfile(dto, file: file, token: '');

  @override
  Future<ClientProfileDto> updateClientProfile(String id, UpdateClientProfileDto dto, {File? file}) =>
      remoteSource.updateClientProfile(id, dto, file: file, token: '');

  @override
  Future<ClientProfileDto> updateClientProfileImage(String id, File file) =>
      remoteSource.updateClientProfileImage(id, file, token: '');

  @override
  Future<void> deleteClientProfile(String id) => remoteSource.deleteClientProfile(id, token: '');
}
