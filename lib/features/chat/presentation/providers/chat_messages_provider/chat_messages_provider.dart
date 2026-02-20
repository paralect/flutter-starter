import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../domain/entities/message_entity.dart';
import '../chat_providers/chat_providers.dart';

part 'chat_messages_provider.g.dart';

@riverpod
class ChatMessages extends _$ChatMessages {
  @override
  Future<List<MessageEntity>> build(String chatId) async {
    final useCase = ref.read(getMessagesUseCaseProvider);
    return await useCase(chatId);
  }

  Future<void> refresh(String chatId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final useCase = ref.read(getMessagesUseCaseProvider);
      return await useCase(chatId);
    });
  }

  Future<void> loadMessages(String chatId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final useCase = ref.read(getMessagesUseCaseProvider);
      return await useCase(chatId);
    });
  }
}
