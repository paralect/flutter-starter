class UserEntity {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String? avatarUrl;
  final DateTime? createdOn;

  UserEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.avatarUrl,
    this.createdOn,
  });
}
