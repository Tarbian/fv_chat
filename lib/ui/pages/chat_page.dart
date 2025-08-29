import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fv_chat/di/di.dart';
import 'package:fv_chat/ui/bloc/chat_cubit.dart';
import 'package:fv_chat/ui/bloc/chat_state.dart';
import 'package:fv_chat/ui/styles/app_colors.dart';
import 'package:fv_chat/ui/styles/app_text_styles.dart';
import 'package:fv_chat/ui/widgets/input_row.dart';
import 'package:fv_chat/ui/widgets/message_bubble.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => getIt<ChatCubit>(),
        child: Scaffold(
          backgroundColor: AppColors.darkGrey800,
          appBar: AppBar(
            backgroundColor: AppColors.darkGrey800,
            title: Text(
              'AI Assistant',
              style: AppTextStyles.h1.copyWith(color: AppColors.white),
            ),
            centerTitle: true,
            elevation: 2,
            scrolledUnderElevation: 0,
            surfaceTintColor: Colors.transparent,
            iconTheme: const IconThemeData(color: AppColors.white),
          ),
          body: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => FocusScope.of(context).unfocus(),
            child: BlocConsumer<ChatCubit, ChatState>(
              listenWhen: (previous, current) =>
                  previous.messages != current.messages ||
                  previous.errorMessage != current.errorMessage,
              listener: (context, state) {
                if (state.messages.isNotEmpty) {
                  _scrollToBottom();
                }

                if (state.errorMessage != null) {
                  if (state.lastFailedMessage != null) {
                    _messageController.text = state.lastFailedMessage!;
                  }

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Row(
                        children: [
                          const Icon(Icons.error_outline,
                              color: Colors.white, size: 20),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              state.errorMessage!,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      backgroundColor: AppColors.alertRed,
                      duration: const Duration(seconds: 4),
                      behavior: SnackBarBehavior.floating,
                      action: SnackBarAction(
                        label: 'OK',
                        textColor: Colors.white,
                        onPressed: () => context.read<ChatCubit>().clearError(),
                      ),
                    ),
                  );

                  context.read<ChatCubit>().clearError();
                }
              },
              builder: (context, state) {
                final cubit = context.read<ChatCubit>();
                final messages = state.messages;

                return Column(
                  children: [
                    Expanded(
                      child: messages.isEmpty
                          ? Center(
                              child: Text(
                                'Ask me anything!',
                                style: AppTextStyles.h2.copyWith(
                                  color: AppColors.grey200,
                                ),
                              ),
                            )
                          : ListView.builder(
                              controller: _scrollController,
                              padding: const EdgeInsets.all(16),
                              itemCount: messages.length,
                              itemBuilder: (context, index) {
                                final message = messages[index];
                                return MessageBubble(
                                  message: message,
                                  onCopy: () => Clipboard.setData(
                                      ClipboardData(text: message.text)),
                                  onRegenerate: () => context
                                      .read<ChatCubit>()
                                      .regenerateLast(),
                                );
                              },
                            ),
                    ),
                    InputRow(
                      controller: _messageController,
                      onSend: () {
                        final text = _messageController.text.trim();
                        if (text.isNotEmpty && !state.isLoading) {
                          cubit.sendMessage(text);
                          _messageController.clear();
                        }
                      },
                      isLoading: state.isLoading,
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      );

  @override
  void dispose() {
    _messageController.dispose();
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
}
