import 'package:flutter/material.dart';
import 'package:fv_chat/common/entities/chat_message.dart';
import 'package:fv_chat/common/entities/mock_data.dart';
import 'package:fv_chat/common/styles/app_colors.dart';
import 'package:fv_chat/common/styles/app_text_styles.dart';
import 'package:fv_chat/common/styles/app_input_styles.dart';
import 'package:fv_chat/common/widgets/chat_bubble.dart';
import 'package:fv_chat/common/widgets/cyrcle_button.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [];
  final ScrollController _scrollController = ScrollController();

  bool _isWaitingForResponse = false;

  final String _mockResponse = MockData.mockResponse;

  void _sendMessage() {
    if (_isWaitingForResponse || _messageController.text.trim().isEmpty) return;

    final userMessage = ChatMessage(
      text: _messageController.text,
      isUser: true,
      timestamp: DateTime.now(),
    );

    setState(() {
      _messages.add(userMessage);
      _isWaitingForResponse = true;
    });

    _messageController.clear();
    _scrollToBottom();

    Future.delayed(const Duration(seconds: 1), () {
      final botMessage = ChatMessage(
        text: _mockResponse,
        isUser: false,
        timestamp: DateTime.now(),
      );

      setState(() {
        _messages.add(botMessage);
        _isWaitingForResponse = false;
      });

      _scrollToBottom();
    });
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

  Widget _buildMessageBubble(ChatMessage message) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment:
            message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          ChatBubble(
            message: message.text,
            isUser: message.isUser,
            backgroundColor:
                message.isUser ? AppColors.neon : AppColors.grey400,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkGrey800,
      appBar: AppBar(
        backgroundColor: AppColors.darkGrey800,
        title: Text(
          'AI Provider',
          style: AppTextStyles.h1.copyWith(color: AppColors.white),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: _messages.isEmpty
                ? const Center(
                    child: Text(
                      'Ask somethig!',
                      style: TextStyle(
                        color: AppColors.grey200,
                        fontSize: 16,
                      ),
                    ),
                  )
                : ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(16),
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final message = _messages[index];
                      return _buildMessageBubble(message);
                    },
                  ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: AppColors.grey600,
              border: Border(
                top: BorderSide(
                  color: AppColors.grey400,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 45,
                    child: TextField(
                      controller: _messageController,
                      decoration: AppInputStyles.defaultInput(
                        hintText: 'Enter a message...',
                      ),
                      style: AppTextStyles.body1.copyWith(
                        color: AppColors.white,
                      ),
                      maxLines: 1,
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                CircleButton(
                  onPressed: _isWaitingForResponse ? null : _sendMessage,
                  icon: Icons.send,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
