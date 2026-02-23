import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ship_flutter_starter/features/chat/domain/entities/chat_entity.dart';
import 'package:ship_flutter_starter/features/chat/data/models/create_chat_request/create_chat_request.dart';
import 'package:ship_flutter_starter/features/chat/presentation/providers/chat_providers/chat_providers.dart';

part 'chats_list_provider.g.dart';

@riverpod
class ChatsList extends _$ChatsList {
  @override
  Future<List<ChatEntity>> build() async {
    final useCase = ref.read(getChatsUseCaseProvider);
    return await useCase();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final useCase = ref.read(getChatsUseCaseProvider);
      return await useCase();
    });
  }

  Future<ChatEntity?> createChat({String? title}) async {
    state = const AsyncValue.loading();
    try {
      final createUseCase = ref.read(createChatUseCaseProvider);
      final createChatRequest = CreateChatRequest(title: title);
      final newChat = await createUseCase(createChatRequest);
      
      final getUseCase = ref.read(getChatsUseCaseProvider);
      final chats = await getUseCase();
      state = AsyncValue.data(chats);
      
      return newChat;
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      return null;
    }
  }

  Future<void> deleteChat(String chatId) async {
    final currentChats = state.valueOrNull;
    if (currentChats == null) return;

    if (state.isLoading) return;

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final deleteUseCase = ref.read(deleteChatUseCaseProvider);
      await deleteUseCase(chatId);
      
      final getUseCase = ref.read(getChatsUseCaseProvider);
      return await getUseCase();
    });
  }
}
