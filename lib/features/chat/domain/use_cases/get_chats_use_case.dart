import 'package:ship_flutter_starter/features/chat/domain/entities/chat_entity.dart';
import 'package:ship_flutter_starter/features/chat/domain/repositories/chat_repository_interface.dart';

class GetChatsUseCase {
  final ChatRepository _repository;

  GetChatsUseCase(this._repository);

  Future<List<ChatEntity>> call() async {
    return await _repository.getChats();
  }
}
