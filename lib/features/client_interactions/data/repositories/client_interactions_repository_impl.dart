import '../../domain/repositories/client_interactions_repository.dart';
import '../models/client_interaction_dto.dart';
import '../models/create_client_interaction_dto.dart';
import '../sources/client_interaction_remote_source.dart';

class ClientInteractionsRepositoryImpl implements ClientInteractionsRepository {
  final ClientInteractionRemoteSource remoteSource;

  ClientInteractionsRepositoryImpl(this.remoteSource);

  @override
  Future<List<ClientInteractionDto>> getClientInteractions(String clientId) {
    return remoteSource.getClientInteractions(clientId);
  }

  @override
  Future<void> createClientInteraction(CreateClientInteractionDto dto) {
    return remoteSource.createClientInteraction(dto);
  }

  @override
  Future<void> updateClientInteraction(String id, CreateClientInteractionDto dto) {
    return remoteSource.updateClientInteraction(id, dto);
  }

  @override
  Future<void> deleteClientInteraction(String id) {
    return remoteSource.deleteClientInteraction(id);
  }
}
