import 'package:ship_flutter_starter/features/chat/data/models/message_model/message_model.dart';

class MessageEntity {
  final String id;
  final String chatId;
  final MessageRole role;
  final String content;
  final DateTime createdOn;

  MessageEntity({
    required this.id,
    required this.chatId,
    required this.role,
    required this.content,
    required this.createdOn,
  });
}
