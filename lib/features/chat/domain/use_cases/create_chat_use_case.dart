import '../entities/chat_entity.dart';
import '../repositories/chat_repository_interface.dart';
import '../../data/models/create_chat_request/create_chat_request.dart';

class CreateChatUseCase {
  final ChatRepository _repository;

  CreateChatUseCase(this._repository);

  Future<ChatEntity> call(CreateChatRequest request) async {
    return await _repository.createChat(request);
  }
}
