import 'package:dio/dio.dart';
import '../models/client_note_dto.dart';
import '../models/create_client_note_dto.dart';

class ClientNoteRemoteSource {
  final Dio dio;

  ClientNoteRemoteSource(this.dio);

  Future<List<ClientNoteDto>> getClientNotes(String clientId) async {
    final response = await dio.get('/clients/$clientId/notes');
    return (response.data as List).map((e) => ClientNoteDto.fromJson(e)).toList();
  }

  Future<void> createClientNote(CreateClientNoteDto dto) async {
    await dio.post('/client_notes', data: dto.toJson());
  }

  Future<void> updateClientNote(String id, CreateClientNoteDto dto) async {
    await dio.put('/client_notes/$id', data: dto.toJson());
  }

  Future<void> deleteClientNote(String id) async {
    await dio.delete('/client_notes/$id');
  }
}
