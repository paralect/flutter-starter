// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UsersListResponseModel _$UsersListResponseModelFromJson(
  Map<String, dynamic> json,
) => UsersListResponseModel(
  results: (json['results'] as List<dynamic>)
      .map((e) => UserModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  count: (json['count'] as num).toInt(),
  pagesCount: (json['pagesCount'] as num).toInt(),
);

Map<String, dynamic> _$UsersListResponseModelToJson(
  UsersListResponseModel instance,
) => <String, dynamic>{
  'results': instance.results,
  'count': instance.count,
  'pagesCount': instance.pagesCount,
};
