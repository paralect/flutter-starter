import 'package:ship_flutter_starter/features/chat/domain/entities/message_entity.dart';
import 'package:ship_flutter_starter/features/chat/domain/repositories/chat_repository_interface.dart';

class GetMessagesUseCase {
  final ChatRepository _repository;

  GetMessagesUseCase(this._repository);

  Future<List<MessageEntity>> call(String chatId) async {
    return await _repository.getMessages(chatId);
  }
}
