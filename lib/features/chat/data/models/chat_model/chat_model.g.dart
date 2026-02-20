// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatModel _$ChatModelFromJson(Map<String, dynamic> json) => ChatModel(
  id: json['_id'] as String,
  userId: json['userId'] as String,
  title: json['title'] as String,
  createdOn: DateTime.parse(json['createdOn'] as String),
  updatedOn: DateTime.parse(json['updatedOn'] as String),
);

Map<String, dynamic> _$ChatModelToJson(ChatModel instance) => <String, dynamic>{
  '_id': instance.id,
  'userId': instance.userId,
  'title': instance.title,
  'createdOn': instance.createdOn.toIso8601String(),
  'updatedOn': instance.updatedOn.toIso8601String(),
};
