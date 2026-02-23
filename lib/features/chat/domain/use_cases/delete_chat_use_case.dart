import 'package:ship_flutter_starter/features/chat/domain/repositories/chat_repository_interface.dart';

class DeleteChatUseCase {
  final ChatRepository _repository;

  DeleteChatUseCase(this._repository);

  Future<void> call(String chatId) async {
    await _repository.deleteChat(chatId);
  }
}
