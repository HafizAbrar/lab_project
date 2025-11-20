import '../../data/models/create_support_ticket_dto.dart';
import '../../data/models/support_ticket_dto.dart';
import '../../data/models/create_support_reply_dto.dart';
import '../../data/models/support_reply_dto.dart';

abstract class SupportTicketsRepository {
  // Tickets
  Future<List<SupportTicketDto>> getAllTickets();
  Future<void> createTicket(CreateSupportTicketDto dto);
  Future<void> updateTicketStatus(String id, String status);
  Future<void> deleteTicket(String id);

  // Replies
  Future<List<SupportReplyDto>> getReplies(String ticketId);
  Future<void> createReply(CreateSupportReplyDto dto);
  Future<void> deleteReply(String id);
}
