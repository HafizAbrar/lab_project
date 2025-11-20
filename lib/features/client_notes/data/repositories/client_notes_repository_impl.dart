import '../../domain/repositories/client_notes_repository.dart';
import '../models/client_note_dto.dart';
import '../models/create_client_note_dto.dart';
import '../sources/client_note_remote_source.dart';

class ClientNotesRepositoryImpl implements ClientNotesRepository {
  final ClientNoteRemoteSource remoteSource;

  ClientNotesRepositoryImpl(this.remoteSource);

  @override
  Future<List<ClientNoteDto>> getClientNotes(String clientId) {
    return remoteSource.getClientNotes(clientId);
  }

  @override
  Future<void> createClientNote(CreateClientNoteDto dto) {
    return remoteSource.createClientNote(dto);
  }

  @override
  Future<void> updateClientNote(String id, CreateClientNoteDto dto) {
    return remoteSource.updateClientNote(id, dto);
  }

  @override
  Future<void> deleteClientNote(String id) {
    return remoteSource.deleteClientNote(id);
  }
}
