import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/message_dto.dart';
import '../../domain/repositories/messaging_repository.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../providers/messaging_providers.dart';

class MessagingController extends StateNotifier<AsyncValue<List<MessageDto>>> {
  final MessagingRepository repository;
  WebSocketChannel? _channel;

  MessagingController(this.repository) : super(const AsyncValue.data([]));

  void connectToChat(String chatRoomId) {
    _channel = WebSocketChannel.connect(Uri.parse('wss://api.example.com/ws/$chatRoomId'));

    _channel!.stream.listen((event) {
      final newMessage = MessageDto.fromJson(event);
      state = AsyncValue.data([...state.value ?? [], newMessage]);
    });
  }

  Future<void> sendMessage(MessageDto dto) async {
    await repository.sendMessage(dto);
    _channel?.sink.add(dto.toJson());
  }

  Future<void> loadMessages(String chatRoomId) async {
    state = const AsyncValue.loading();
    try {
      final messages = await repository.getMessages(chatRoomId);
      state = AsyncValue.data(messages);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  @override
  void dispose() {
    _channel?.sink.close();
    super.dispose();
  }
}

final messagingControllerProvider =
StateNotifierProvider<MessagingController, AsyncValue<List<MessageDto>>>(
      (ref) => MessagingController(ref.read(messagingRepositoryProvider)),
);
