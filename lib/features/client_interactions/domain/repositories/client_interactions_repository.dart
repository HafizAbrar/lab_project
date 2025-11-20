import '../../data/models/client_interaction_dto.dart';
import '../../data/models/create_client_interaction_dto.dart';

abstract class ClientInteractionsRepository {
  Future<List<ClientInteractionDto>> getClientInteractions(String clientId);
  Future<void> createClientInteraction(CreateClientInteractionDto dto);
  Future<void> updateClientInteraction(String id, CreateClientInteractionDto dto);
  Future<void> deleteClientInteraction(String id);
}
