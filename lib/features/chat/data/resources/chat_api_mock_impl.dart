import 'dart:async';
import '../interfaces/chat_api_interface.dart';
import '../models/chat_model/chat_model.dart';
import '../models/message_model/message_model.dart';
import '../models/create_chat_request/create_chat_request.dart';
import '../models/send_message_request/send_message_request.dart';

class ChatApiMockImpl implements ChatApiInterface {
  final List<ChatModel> _mockChats = [];
  final Map<String, List<MessageModel>> _mockMessages = {};
  int _chatCounter = 2;
  int _messageCounter = 0;

  ChatApiMockImpl() {
    _initializeMockData();
  }

  void _initializeMockData() {
    final chat1 = ChatModel(
      id: 'chat_1',
      userId: 'user_1',
      title: 'Flutter Development',
      createdOn: DateTime.now().subtract(const Duration(days: 2)),
      updatedOn: DateTime.now().subtract(const Duration(hours: 1)),
    );
    final chat2 = ChatModel(
      id: 'chat_2',
      userId: 'user_1',
      title: 'API Integration',
      createdOn: DateTime.now().subtract(const Duration(days: 1)),
      updatedOn: DateTime.now().subtract(const Duration(minutes: 30)),
    );

    _mockChats.addAll([chat1, chat2]);

    _mockMessages['chat_1'] = [
      MessageModel(
        id: 'msg_1',
        chatId: 'chat_1',
        role: MessageRole.user,
        content: 'How do I implement state management in Flutter?',
        createdOn: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      MessageModel(
        id: 'msg_2',
        chatId: 'chat_1',
        role: MessageRole.assistant,
        content:
            'Flutter offers several state management solutions. The most popular ones are:\n\n1. **Riverpod** - Modern, type-safe state management\n2. **Provider** - Simple and lightweight\n3. **Bloc** - Event-driven architecture\n4. **GetX** - All-in-one solution\n\nFor your project, I recommend using Riverpod as it provides excellent type safety and testability.',
        createdOn: DateTime.now().subtract(
          const Duration(hours: 2, minutes: 1),
        ),
      ),
    ];

    _mockMessages['chat_2'] = [
      MessageModel(
        id: 'msg_3',
        chatId: 'chat_2',
        role: MessageRole.user,
        content: 'What is the best way to handle API calls in Flutter?',
        createdOn: DateTime.now().subtract(const Duration(hours: 1)),
      ),
      MessageModel(
        id: 'msg_4',
        chatId: 'chat_2',
        role: MessageRole.assistant,
        content:
            'For API calls in Flutter, I recommend using **Dio** package. It provides:\n\n- Interceptors for request/response handling\n- Request cancellation\n- Timeout configuration\n- Error handling\n- File upload/download support\n\nYou can combine it with Riverpod for state management and create a clean architecture with repositories and use cases.',
        createdOn: DateTime.now().subtract(
          const Duration(hours: 1, minutes: 1),
        ),
      ),
    ];
  }

  @override
  Future<List<ChatModel>> getChats() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return List.from(_mockChats);
  }

  @override
  Future<ChatModel> createChat(CreateChatRequest request) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _chatCounter++;
    final newChat = ChatModel(
      id: 'chat_$_chatCounter',
      userId: 'user_1',
      title: request.title ?? 'New Chat',
      createdOn: DateTime.now(),
      updatedOn: DateTime.now(),
    );
    _mockChats.insert(0, newChat);
    _mockMessages[newChat.id] = [];
    return newChat;
  }

  @override
  Future<List<MessageModel>> getMessages(String chatId) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return List.from(_mockMessages[chatId] ?? []);
  }

  @override
  Stream<Map<String, dynamic>> sendMessage(
    String chatId,
    SendMessageRequest request,
  ) async* {
    _messageCounter++;
    final userMessage = MessageModel(
      id: 'msg_user_$_messageCounter',
      chatId: chatId,
      role: MessageRole.user,
      content: request.content,
      createdOn: DateTime.now(),
    );

    if (_mockMessages[chatId] == null) {
      _mockMessages[chatId] = [];
    }
    _mockMessages[chatId]!.add(userMessage);

    await Future.delayed(const Duration(milliseconds: 200));

    final assistantMessageId = 'msg_assistant_$_messageCounter';
    final responseText = _generateMockResponse(request.content);
    final words = responseText.split(' ');

    for (int i = 0; i < words.length; i++) {
      await Future.delayed(const Duration(milliseconds: 50));
      yield {'type': 'text', 'content': i == 0 ? words[i] : ' ${words[i]}'};
    }

    final assistantMessage = MessageModel(
      id: assistantMessageId,
      chatId: chatId,
      role: MessageRole.assistant,
      content: responseText,
      createdOn: DateTime.now(),
    );

    _mockMessages[chatId]!.add(assistantMessage);

    yield {'type': 'done', 'messageId': assistantMessageId};
  }

  String _generateMockResponse(String userMessage) {
    final lowerMessage = userMessage.toLowerCase();
    if (lowerMessage.contains('flutter')) {
      return 'Flutter is a great framework for cross-platform development. It uses Dart programming language and provides excellent performance with its widget-based architecture.';
    } else if (lowerMessage.contains('api') || lowerMessage.contains('http')) {
      return 'For API integration in Flutter, use the Dio package. It provides comprehensive features for HTTP requests including interceptors, error handling, and request/response transformation.';
    } else if (lowerMessage.contains('state') ||
        lowerMessage.contains('management')) {
      return 'State management in Flutter can be handled using Riverpod, Provider, Bloc, or GetX. Riverpod is recommended for type-safe and testable state management.';
    } else {
      return 'I understand your question about "$userMessage". This is a mock response. Once the API is integrated, you will receive real AI-generated responses.';
    }
  }

  @override
  Future<void> deleteChat(String chatId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    final indexToRemove = _mockChats.indexWhere((chat) => chat.id == chatId);
    if (indexToRemove == -1) {
      throw Exception('Chat with id $chatId not found');
    }
    
    _mockChats.removeAt(indexToRemove);
    _mockMessages.remove(chatId);
  }
}
