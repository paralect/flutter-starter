class ChatEntity {
  final String id;
  final String userId;
  final String title;
  final DateTime createdOn;
  final DateTime updatedOn;

  ChatEntity({
    required this.id,
    required this.userId,
    required this.title,
    required this.createdOn,
    required this.updatedOn,
  });
}
