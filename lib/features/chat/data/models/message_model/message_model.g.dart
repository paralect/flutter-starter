// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageModel _$MessageModelFromJson(Map<String, dynamic> json) => MessageModel(
  id: json['_id'] as String,
  chatId: json['chatId'] as String,
  role: $enumDecode(_$MessageRoleEnumMap, json['role']),
  content: json['content'] as String,
  createdOn: DateTime.parse(json['createdOn'] as String),
);

Map<String, dynamic> _$MessageModelToJson(MessageModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'chatId': instance.chatId,
      'role': _$MessageRoleEnumMap[instance.role]!,
      'content': instance.content,
      'createdOn': instance.createdOn.toIso8601String(),
    };

const _$MessageRoleEnumMap = {
  MessageRole.user: 'user',
  MessageRole.assistant: 'assistant',
};
