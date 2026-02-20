import 'package:json_annotation/json_annotation.dart';

part 'create_chat_request.g.dart';

@JsonSerializable()
class CreateChatRequest {
  final String? title;

  CreateChatRequest({this.title});

  factory CreateChatRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateChatRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateChatRequestToJson(this);
}
