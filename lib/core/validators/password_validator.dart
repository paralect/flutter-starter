import 'package:ship_flutter_starter/core/extensions/string_extensions.dart';

class PasswordValidator {
  static String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (!value.isValidPassword) {
      return 'Password must be at least 8 characters long';
    }
    return null;
  }
}
