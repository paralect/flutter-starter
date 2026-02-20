import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../../core/di/service_locator.dart';
import '../../../domain/repositories/chat_repository_interface.dart';
import '../../../domain/use_cases/create_chat_use_case.dart';
import '../../../domain/use_cases/delete_chat_use_case.dart';
import '../../../domain/use_cases/get_chats_use_case.dart';
import '../../../domain/use_cases/get_messages_use_case.dart';
import '../../../domain/use_cases/send_message_use_case.dart';

part 'chat_providers.g.dart';

@riverpod
ChatRepository chatRepository(Ref ref) {
  return getIt<ChatRepository>();
}

@riverpod
GetChatsUseCase getChatsUseCase(Ref ref) {
  return GetChatsUseCase(ref.watch(chatRepositoryProvider));
}

@riverpod
CreateChatUseCase createChatUseCase(Ref ref) {
  return CreateChatUseCase(ref.watch(chatRepositoryProvider));
}

@riverpod
GetMessagesUseCase getMessagesUseCase(Ref ref) {
  return GetMessagesUseCase(ref.watch(chatRepositoryProvider));
}

@riverpod
SendMessageUseCase sendMessageUseCase(Ref ref) {
  return SendMessageUseCase(ref.watch(chatRepositoryProvider));
}

@riverpod
DeleteChatUseCase deleteChatUseCase(Ref ref) {
  return DeleteChatUseCase(ref.watch(chatRepositoryProvider));
}
