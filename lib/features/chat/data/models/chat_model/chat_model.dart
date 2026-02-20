import 'package:json_annotation/json_annotation.dart';
import '../../../domain/entities/chat_entity.dart';

part 'chat_model.g.dart';

@JsonSerializable()
class ChatModel {
  @JsonKey(name: '_id')
  final String id;
  final String userId;
  final String title;
  @JsonKey(name: 'createdOn')
  final DateTime createdOn;
  @JsonKey(name: 'updatedOn')
  final DateTime updatedOn;

  ChatModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.createdOn,
    required this.updatedOn,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) =>
      _$ChatModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChatModelToJson(this);

  ChatEntity toEntity() {
    return ChatEntity(
      id: id,
      userId: userId,
      title: title,
      createdOn: createdOn,
      updatedOn: updatedOn,
    );
  }
}
