import 'package:dio/dio.dart';
import '../models/message_dto.dart';

class MessagingRemoteSource {
  final Dio dio;

  MessagingRemoteSource(this.dio);

  Future<List<MessageDto>> getMessages(String chatRoomId) async {
    final response = await dio.get('/messages', queryParameters: {'chatRoomId': chatRoomId});
    return (response.data as List).map((e) => MessageDto.fromJson(e)).toList();
  }

  Future<void> sendMessage(MessageDto dto) async {
    await dio.post('/messages', data: dto.toJson());
  }

  // Simulate marking message as read
  Future<void> markAsRead(String messageId) async {
    await dio.patch('/messages/$messageId', data: {'isRead': true});
  }
}
