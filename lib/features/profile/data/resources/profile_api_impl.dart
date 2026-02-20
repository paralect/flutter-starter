import 'package:ship_flutter_starter/core/constants/api_constants.dart';
import 'package:ship_flutter_starter/core/services/api_service.dart';
import 'package:ship_flutter_starter/features/auth/data/models/user_model.dart';
import 'package:ship_flutter_starter/features/profile/data/interfaces/profile_api_interface.dart';
import 'package:ship_flutter_starter/features/profile/data/models/update_profile_request.dart';

class ProfileApiImpl implements ProfileApiInterface {
  final ApiService _apiService;

  ProfileApiImpl(this._apiService);

  @override
  Future<UserModel> getProfile() async {
    final response = await _apiService.get(ApiConstants.account);
    return UserModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<UserModel> updateProfile(
    String firstName,
    String lastName,
    String? avatarUrl,
  ) async {
    final request = UpdateProfileRequest(
      firstName: firstName,
      lastName: lastName,
      avatarUrl: avatarUrl,
    );
    final response = await _apiService.patch(
      ApiConstants.account,
      data: request.toJson(),
    );
    return UserModel.fromJson(response.data as Map<String, dynamic>);
  }
}
