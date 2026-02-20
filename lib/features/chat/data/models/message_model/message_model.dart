import 'package:json_annotation/json_annotation.dart';
import '../../../domain/entities/message_entity.dart';

part 'message_model.g.dart';

@JsonSerializable()
class MessageModel {
  @JsonKey(name: '_id')
  final String id;
  final String chatId;
  final MessageRole role;
  final String content;
  @JsonKey(name: 'createdOn')
  final DateTime createdOn;

  MessageModel({
    required this.id,
    required this.chatId,
    required this.role,
    required this.content,
    required this.createdOn,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$MessageModelToJson(this);

  MessageEntity toEntity() {
    return MessageEntity(
      id: id,
      chatId: chatId,
      role: role,
      content: content,
      createdOn: createdOn,
    );
  }
}

enum MessageRole {
  @JsonValue('user')
  user,
  @JsonValue('assistant')
  assistant,
}
