import '../entities/message_entity.dart';
import '../repositories/chat_repository_interface.dart';

class GetMessagesUseCase {
  final ChatRepository _repository;

  GetMessagesUseCase(this._repository);

  Future<List<MessageEntity>> call(String chatId) async {
    return await _repository.getMessages(chatId);
  }
}
