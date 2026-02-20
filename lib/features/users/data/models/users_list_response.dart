import 'package:json_annotation/json_annotation.dart';
import '../../domain/repositories/users_repository.dart';
import 'user_model.dart';

part 'users_list_response.g.dart';

@JsonSerializable()
class UsersListResponseModel {
  final List<UserModel> results;
  final int count;
  @JsonKey(name: 'pagesCount')
  final int pagesCount;

  UsersListResponseModel({
    required this.results,
    required this.count,
    required this.pagesCount,
  });

  factory UsersListResponseModel.fromJson(Map<String, dynamic> json) =>
      _$UsersListResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$UsersListResponseModelToJson(this);

  UsersListResponse toEntity() {
    return UsersListResponse(
      results: results.map((e) => e.toEntity()).toList(),
      count: count,
      pagesCount: pagesCount,
    );
  }
}
