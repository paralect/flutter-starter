import 'dart:async';
import '../entities/chat_entity.dart';
import '../entities/message_entity.dart';
import '../../data/models/create_chat_request/create_chat_request.dart';
import '../../data/models/send_message_request/send_message_request.dart';

abstract class ChatRepository {
  Future<List<ChatEntity>> getChats();
  Future<ChatEntity> createChat(CreateChatRequest request);
  Future<List<MessageEntity>> getMessages(String chatId);
  Stream<Map<String, dynamic>> sendMessage(String chatId, SendMessageRequest request);
  Future<void> deleteChat(String chatId);
}
