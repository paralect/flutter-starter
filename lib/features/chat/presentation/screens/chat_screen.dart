import 'package:flutter/material.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' as shadcn;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ship_flutter_starter/features/chat/presentation/providers/chat_messages_provider/chat_messages_provider.dart';
import 'package:ship_flutter_starter/features/chat/presentation/providers/send_message_provider/send_message_provider.dart';
import 'package:ship_flutter_starter/features/chat/presentation/widgets/chat_message_bubble.dart';
import 'package:ship_flutter_starter/features/chat/presentation/widgets/chat_input_field.dart';
import 'package:ship_flutter_starter/features/chat/presentation/widgets/typing_indicator.dart';
import 'package:ship_flutter_starter/core/utils/error_handler.dart';

class ChatScreen extends ConsumerStatefulWidget {
  final String chatId;

  const ChatScreen({super.key, required this.chatId});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final ScrollController _scrollController = ScrollController();
  String _inputText = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(chatMessagesProvider(widget.chatId).notifier)
          .loadMessages(widget.chatId);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _handleSendMessage() async {
    if (_inputText.trim().isEmpty) return;

    final content = _inputText.trim();
    _inputText = '';
    setState(() {});

    await ref
        .read(sendMessageProvider.notifier)
        .sendMessage(widget.chatId, content);

    _scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    final messagesAsync = ref.watch(chatMessagesProvider(widget.chatId));
    final sendMessageState = ref.watch(sendMessageProvider);

    final isLoading = sendMessageState.isLoading;

    return Scaffold(
      appBar: AppBar(title: const Text('Chat')),
      body: Column(
        children: [
          Expanded(
            child: messagesAsync.when(
              data: (messages) {
                if (messages.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.chat_bubble_outline,
                          size: 64,
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withValues(alpha: 0.3),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No messages yet',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurface.withValues(alpha: 0.6),
                              ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Start a conversation',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurface.withValues(alpha: 0.5),
                              ),
                        ),
                      ],
                    ),
                  );
                }

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _scrollToBottom();
                });

                return ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: messages.length + (isLoading ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == messages.length) {
                      return const TypingIndicator();
                    }
                    return ChatMessageBubble(message: messages[index]);
                  },
                );
              },
              loading: () =>
                  Center(child: shadcn.CircularProgressIndicator()),
              error: (error, stack) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ErrorHandler.handleError(context, error);
                });
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: 64,
                        color: Colors.red,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Failed to load messages',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      shadcn.Button(
                        style: shadcn.ButtonStyle.primary(),
                        onPressed: () {
                          ref
                              .read(
                                chatMessagesProvider(widget.chatId).notifier,
                              )
                              .refresh(widget.chatId);
                        },
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          ChatInputField(
            initialValue: _inputText,
            onChanged: (value) {
              setState(() {
                _inputText = value;
              });
            },
            onSend: _handleSendMessage,
            isLoading: isLoading,
          ),
        ],
      ),
    );
  }
}
