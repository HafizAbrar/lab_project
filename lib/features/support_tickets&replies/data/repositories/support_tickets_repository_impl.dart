import '../../domain/repositories/support_tickets_repository.dart';
import '../models/create_support_ticket_dto.dart';
import '../models/support_ticket_dto.dart';
import '../models/create_support_reply_dto.dart';
import '../models/support_reply_dto.dart';
import '../sources/support_ticket_remote_source.dart';

class SupportTicketsRepositoryImpl implements SupportTicketsRepository {
  final SupportTicketRemoteSource remoteSource;

  SupportTicketsRepositoryImpl(this.remoteSource);

  @override
  Future<List<SupportTicketDto>> getAllTickets() {
    return remoteSource.getAllTickets();
  }

  @override
  Future<void> createTicket(CreateSupportTicketDto dto) {
    return remoteSource.createTicket(dto);
  }

  @override
  Future<void> updateTicketStatus(String id, String status) {
    return remoteSource.updateTicketStatus(id, status);
  }

  @override
  Future<void> deleteTicket(String id) {
    return remoteSource.deleteTicket(id);
  }

  @override
  Future<List<SupportReplyDto>> getReplies(String ticketId) {
    return remoteSource.getReplies(ticketId);
  }

  @override
  Future<void> createReply(CreateSupportReplyDto dto) {
    return remoteSource.createReply(dto);
  }

  @override
  Future<void> deleteReply(String id) {
    return remoteSource.deleteReply(id);
  }
}
