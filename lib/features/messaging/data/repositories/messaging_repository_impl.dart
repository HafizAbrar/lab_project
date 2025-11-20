import '../../domain/repositories/messaging_repository.dart';
import '../models/message_dto.dart';
import '../sources/messaging_remote_source.dart';

class MessagingRepositoryImpl implements MessagingRepository {
  final MessagingRemoteSource remoteSource;

  MessagingRepositoryImpl(this.remoteSource);

  @override
  Future<List<MessageDto>> getMessages(String chatRoomId) {
    return remoteSource.getMessages(chatRoomId);
  }

  @override
  Future<void> sendMessage(MessageDto dto) {
    return remoteSource.sendMessage(dto);
  }

  @override
  Future<void> markAsRead(String messageId) {
    return remoteSource.markAsRead(messageId);
  }
}
