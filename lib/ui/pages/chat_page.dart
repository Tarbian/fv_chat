import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fv_chat/domain/entities/chat_message.dart';
import 'package:fv_chat/ui/bloc/chat_cubit.dart';
import 'package:fv_chat/ui/styles/app_colors.dart';
import 'package:fv_chat/ui/styles/app_text_styles.dart';
import 'package:fv_chat/ui/widgets/chat_bubble.dart';
import 'package:fv_chat/ui/widgets/input_row.dart';
import 'package:fv_chat/ui/widgets/small_button.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChatCubit(),
      child: BlocConsumer<ChatCubit, ChatState>(
        listener: (context, state) {
          _scrollToBottom();
        },
        builder: (context, state) {
          final cubit = context.read<ChatCubit>();
          final messages = state.messages;

          return Scaffold(
            backgroundColor: AppColors.darkGrey800,
            appBar: AppBar(
              backgroundColor: AppColors.darkGrey800,
              title: Text('AI Provider',
                  style: AppTextStyles.h1.copyWith(color: AppColors.white)),
              centerTitle: true,
              elevation: 2,
              scrolledUnderElevation: 0,
              surfaceTintColor: Colors.transparent,
            ),
            body: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => FocusScope.of(context).unfocus(),
              child: Column(
                children: [
                  Expanded(
                    child: messages.isEmpty
                        ? const Center(
                            child: Text(
                              'Ask something!',
                              style: AppTextStyles.backgoundHint,
                            ),
                          )
                        : ListView.builder(
                            controller: _scrollController,
                            padding: const EdgeInsets.all(16),
                            itemCount: messages.length,
                            itemBuilder: (context, index) {
                              final message = messages[index];
                              return _buildMessageBubble(message, cubit);
                            },
                          ),
                  ),
                  InputRow(
                    controller: _messageController,
                    onSend: () {
                      cubit.sendMessage(_messageController.text);
                      _messageController.clear();
                    },
                    isWaitingForResponse: state.isLoading,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
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

  Widget _buildMessageBubble(ChatMessage message, ChatCubit cubit) {
    final isBot = !message.isUser;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment:
            message.isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: message.isUser
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              ChatBubble(
                message: message.text,
                isUser: message.isUser,
                backgroundColor:
                    message.isUser ? AppColors.neon : AppColors.grey400,
              ),
            ],
          ),
          if (isBot)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SmallButton(
                  icon: const Icon(Icons.copy),
                  onPressed: () => _copyToClipboard(message.text),
                ),
                SmallButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: cubit.regenerateLast,
                ),
              ],
            ),
        ],
      ),
    );
  }
}
