import 'dart:async';
import 'package:ship_flutter_starter/features/chat/data/models/chat_model/chat_model.dart';
import 'package:ship_flutter_starter/features/chat/data/models/message_model/message_model.dart';
import 'package:ship_flutter_starter/features/chat/data/models/create_chat_request/create_chat_request.dart';
import 'package:ship_flutter_starter/features/chat/data/models/send_message_request/send_message_request.dart';

abstract class ChatApiInterface {
  Future<List<ChatModel>> getChats();
  Future<ChatModel> createChat(CreateChatRequest request);
  Future<List<MessageModel>> getMessages(String chatId);
  Stream<Map<String, dynamic>> sendMessage(String chatId, SendMessageRequest request);
  Future<void> deleteChat(String chatId);
}
