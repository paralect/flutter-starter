# Chat Feature

## Current Status

The chat feature is implemented using **API mocks** to work without dependency on the unmerged auth API.

## Structure

```bash
features/chat/
├── data/
│   ├── models/              # Data models (each in its own folder)
│   │   ├── chat_model/
│   │   ├── message_model/
│   │   ├── create_chat_request/
│   │   └── send_message_request/
│   ├── interfaces/         # API interfaces
│   ├── resources/
│   │   ├── chat_api_mock_impl.dart  # Mock API implementation
│   │   └── chat_repository_impl.dart # Repository implementation
│   └── repositories/        # Repository interfaces
├── domain/
│   ├── entities/            # Domain entities
│   └── use_cases/           # Use cases
└── presentation/
    ├── providers/            # Riverpod providers (each in its own folder)
    │   ├── chat_providers/
    │   ├── chats_list_provider/
    │   ├── chat_messages_provider/
    │   └── send_message_provider/
    ├── screens/              # Screens (ChatsListScreen, ChatScreen)
    └── widgets/              # UI widgets
```

**Note**: All files with code generation (models with `@JsonSerializable`, providers with `@riverpod`) are organized in separate folders following the feature structure rules.

## Functionality

- ✅ Chat list
- ✅ Create new chat
- ✅ View chat messages
- ✅ Send messages with streaming response (mock)
- ✅ Delete chat
- ✅ UI components (ChatMessageBubble, ChatInputField, TypingIndicator)

## Switching to Real API

When the auth API is merged, you need to:

1. **Create real API implementation** (`chat_api_impl.dart`):

   ```dart
   class ChatApiImpl implements ChatApiInterface {
     final ApiService _apiService;
     
     // Implement methods with real HTTP requests
     // Use SSE client for streaming
   }
   ```

2. **Update DI** in `service_locator.dart`:

   ```dart
   // Replace ChatApiMockImpl with ChatApiImpl
   getIt.registerSingleton<ChatApiInterface>(
     ChatApiImpl(getIt<ApiService>()), // instead of ChatApiMockImpl()
   );
   ```

3. **Add API constants** in `api_constants.dart`:

   ```dart
   static const String chats = '/chats';
   static const String chatMessages = '/chats/{chatId}/messages';
   ```

4. **Implement SSE streaming** for `sendMessage`:
   - Use `dio` with custom ResponseTransformer
   - Or use `sse_client` package for Server-Sent Events
   - Parse events in format: `data: {"type": "text", "content": "..."}`

## Routing

- `/chats` - chat list
- `/chats/:chatId` - chat screen with messages

## Mocks

Mocks return data with delays to simulate network requests:

- `getChats()` - 500ms
- `createChat()` - 300ms
- `getMessages()` - 400ms
- `sendMessage()` - streaming with 50ms delay between words
- `deleteChat()` - 300ms
