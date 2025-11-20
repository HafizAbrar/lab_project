import 'package:dio/dio.dart';

import '../models/create_support_ticket_dto.dart';
import '../models/support_ticket_dto.dart';
import '../models/create_support_reply_dto.dart';
import '../models/support_reply_dto.dart';

class SupportTicketRemoteSource {
  final Dio dio;

  SupportTicketRemoteSource(this.dio);

  // ---- Tickets ----
  Future<List<SupportTicketDto>> getAllTickets() async {
    final response = await dio.get('/support-tickets');
    return (response.data as List)
        .map((e) => SupportTicketDto.fromJson(e))
        .toList();
  }

  Future<void> createTicket(CreateSupportTicketDto dto) async {
    await dio.post('/support-tickets', data: dto.toJson());
  }

  Future<void> updateTicketStatus(String id, String status) async {
    await dio.put('/support-tickets/$id', data: {'status': status});
  }

  Future<void> deleteTicket(String id) async {
    await dio.delete('/support-tickets/$id');
  }

  // ---- Replies ----
  Future<List<SupportReplyDto>> getReplies(String ticketId) async {
    final response = await dio.get('/support-tickets/$ticketId/replies');
    return (response.data as List)
        .map((e) => SupportReplyDto.fromJson(e))
        .toList();
  }

  Future<void> createReply(CreateSupportReplyDto dto) async {
    await dio.post('/support-replies', data: dto.toJson());
  }

  Future<void> deleteReply(String id) async {
    await dio.delete('/support-replies/$id');
  }
}
