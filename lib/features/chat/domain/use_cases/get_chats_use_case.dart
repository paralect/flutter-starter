import '../entities/chat_entity.dart';
import '../repositories/chat_repository_interface.dart';

class GetChatsUseCase {
  final ChatRepository _repository;

  GetChatsUseCase(this._repository);

  Future<List<ChatEntity>> call() async {
    return await _repository.getChats();
  }
}
