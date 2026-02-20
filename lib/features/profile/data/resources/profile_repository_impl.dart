import 'package:ship_flutter_starter/features/auth/domain/entities/user_entity.dart';
import 'package:ship_flutter_starter/features/profile/data/interfaces/profile_api_interface.dart';
import 'package:ship_flutter_starter/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileApiInterface _api;

  ProfileRepositoryImpl(this._api);

  @override
  Future<UserEntity> getProfile() async {
    final userModel = await _api.getProfile();
    return userModel.toEntity();
  }

  @override
  Future<UserEntity> updateProfile(
    String firstName,
    String lastName,
    String? avatarUrl,
  ) async {
    final userModel = await _api.updateProfile(firstName, lastName, avatarUrl);
    return userModel.toEntity();
  }
}
