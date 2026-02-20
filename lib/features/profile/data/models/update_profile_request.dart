import 'package:json_annotation/json_annotation.dart';

part 'update_profile_request.g.dart';

@JsonSerializable()
class UpdateProfileRequest {
  final String firstName;
  final String lastName;
  @JsonKey(name: 'avatarUrl', includeIfNull: false)
  final String? avatarUrl;

  UpdateProfileRequest({
    required this.firstName,
    required this.lastName,
    this.avatarUrl,
  });

  factory UpdateProfileRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateProfileRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateProfileRequestToJson(this);
}
