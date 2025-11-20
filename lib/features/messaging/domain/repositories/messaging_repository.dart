import '../../data/models/message_dto.dart';

abstract class MessagingRepository {
  Future<List<MessageDto>> getMessages(String chatRoomId);
  Future<void> sendMessage(MessageDto dto);
  Future<void> markAsRead(String messageId);
}
