import '../../data/models/client_note_dto.dart';
import '../../data/models/create_client_note_dto.dart';

abstract class ClientNotesRepository {
  Future<List<ClientNoteDto>> getClientNotes(String clientId);
  Future<void> createClientNote(CreateClientNoteDto dto);
  Future<void> updateClientNote(String id, CreateClientNoteDto dto);
  Future<void> deleteClientNote(String id);
}
