import 'package:dio/dio.dart';
import '../models/client_interaction_dto.dart';
import '../models/create_client_interaction_dto.dart';

class ClientInteractionRemoteSource {
  final Dio dio;

  ClientInteractionRemoteSource(this.dio);

  Future<List<ClientInteractionDto>> getClientInteractions(String clientId) async {
    final response = await dio.get('/clients/$clientId/interactions');
    return (response.data as List)
        .map((e) => ClientInteractionDto.fromJson(e))
        .toList();
  }

  Future<void> createClientInteraction(CreateClientInteractionDto dto) async {
    await dio.post('/client_interactions', data: dto.toJson());
  }

  Future<void> updateClientInteraction(String id, CreateClientInteractionDto dto) async {
    await dio.put('/client_interactions/$id', data: dto.toJson());
  }

  Future<void> deleteClientInteraction(String id) async {
    await dio.delete('/client_interactions/$id');
  }
}
