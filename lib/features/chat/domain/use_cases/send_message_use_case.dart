import 'dart:async';
import '../repositories/chat_repository_interface.dart';
import '../../data/models/send_message_request/send_message_request.dart';

class SendMessageUseCase {
  final ChatRepository _repository;

  SendMessageUseCase(this._repository);

  Stream<Map<String, dynamic>> call(String chatId, SendMessageRequest request) {
    return _repository.sendMessage(chatId, request);
  }
}
