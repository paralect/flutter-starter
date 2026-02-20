import '../../../../core/constants/api_constants.dart';
import '../../../../core/services/api_service.dart';
import '../interfaces/users_api_interface.dart';
import '../models/users_list_response.dart';
import '../../domain/repositories/users_repository.dart';

class UsersApiImpl implements UsersApiInterface {
  final ApiService _apiService;

  UsersApiImpl(this._apiService);

  @override
  Future<UsersListResponseModel> getUsersList(UsersListParams params) async {
    final queryParams = <String, dynamic>{
      'page': params.page,
      'perPage': params.perPage,
    };

    if (params.searchValue != null && params.searchValue!.isNotEmpty) {
      queryParams['searchValue'] = params.searchValue;
    }

    if (params.sort != null && params.sort!.isNotEmpty) {
      params.sort!.forEach((key, value) {
        queryParams['sort[$key]'] = value;
      });
    }

    final response = await _apiService.get(
      ApiConstants.users,
      queryParameters: queryParams,
    );

    return UsersListResponseModel.fromJson(
      response.data as Map<String, dynamic>,
    );
  }
}
