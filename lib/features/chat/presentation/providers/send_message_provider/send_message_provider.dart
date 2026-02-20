import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../domain/entities/message_entity.dart';
import '../../../data/models/message_model/message_model.dart';
import '../../../data/models/send_message_request/send_message_request.dart';
import '../chat_providers/chat_providers.dart';
import '../chat_messages_provider/chat_messages_provider.dart';

part 'send_message_provider.g.dart';

@riverpod
class SendMessage extends _$SendMessage {
  String? _streamingContent;

  @override
  FutureOr<void> build() {}

  Future<void> sendMessage(String chatId, String content) async {
    state = const AsyncValue.loading();
    _streamingContent = '';

    try {
      final useCase = ref.read(sendMessageUseCaseProvider);
      final request = SendMessageRequest(content: content);
      
      final messagesNotifier = ref.read(chatMessagesProvider(chatId).notifier);
      await messagesNotifier.loadMessages(chatId);
      
      final currentMessages = messagesNotifier.state.valueOrNull ?? <MessageEntity>[];
      final tempMessageId = 'temp_${DateTime.now().millisecondsSinceEpoch}';
      
      await for (final event in useCase(chatId, request)) {
        if (event['type'] == 'text') {
          _streamingContent = (_streamingContent ?? '') + (event['content'] as String);
          
          final tempMessage = MessageEntity(
            id: tempMessageId,
            chatId: chatId,
            role: MessageRole.assistant,
            content: _streamingContent!,
            createdOn: DateTime.now(),
          );
          
          final updatedMessages = <MessageEntity>[...currentMessages, tempMessage];
          messagesNotifier.state = AsyncValue.data(updatedMessages);
        } else if (event['type'] == 'done') {
          await messagesNotifier.refresh(chatId);
          state = const AsyncValue.data(null);
          break;
        } else if (event['type'] == 'error') {
          final errorMessage = event['message'] as String? ?? 'Failed to send message';
          state = AsyncValue.error(errorMessage, StackTrace.current);
          break;
        }
      }
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}
