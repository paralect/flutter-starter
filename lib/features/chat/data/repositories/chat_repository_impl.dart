import 'package:ship_flutter_starter/features/chat/domain/repositories/chat_repository_interface.dart';
import 'package:ship_flutter_starter/features/chat/domain/entities/chat_entity.dart';
import 'package:ship_flutter_starter/features/chat/domain/entities/message_entity.dart';
import 'package:ship_flutter_starter/features/chat/data/interfaces/chat_api_interface.dart';
import 'package:ship_flutter_starter/features/chat/data/models/create_chat_request/create_chat_request.dart';
import 'package:ship_flutter_starter/features/chat/data/models/send_message_request/send_message_request.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatApiInterface _api;

  ChatRepositoryImpl(this._api);

  @override
  Future<List<ChatEntity>> getChats() async {
    final chats = await _api.getChats();
    return chats.map((chat) => chat.toEntity()).toList();
  }

  @override
  Future<ChatEntity> createChat(CreateChatRequest request) async {
    final chat = await _api.createChat(request);
    return chat.toEntity();
  }

  @override
  Future<List<MessageEntity>> getMessages(String chatId) async {
    final messages = await _api.getMessages(chatId);
    return messages.map((message) => message.toEntity()).toList();
  }

  @override
  Stream<Map<String, dynamic>> sendMessage(String chatId, SendMessageRequest request) {
    return _api.sendMessage(chatId, request);
  }

  @override
  Future<void> deleteChat(String chatId) async {
    await _api.deleteChat(chatId);
  }
}
