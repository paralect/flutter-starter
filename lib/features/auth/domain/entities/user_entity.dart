class UserEntity {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final bool isEmailVerified;
  final String? avatarUrl;

  UserEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.isEmailVerified,
    this.avatarUrl,
  });
}
