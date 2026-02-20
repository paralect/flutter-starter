import 'package:ship_flutter_starter/features/auth/data/models/user_model.dart';

abstract class ProfileApiInterface {
  Future<UserModel> getProfile();
  Future<UserModel> updateProfile(String firstName, String lastName, String? avatarUrl);
}
