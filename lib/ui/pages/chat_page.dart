import 'package:flutter/material.dart';
import 'package:fv_chat/model/entities/chat_message.dart';
import 'package:fv_chat/model/entities/mock_data.dart';
import 'package:fv_chat/ui/styles/app_colors.dart';
import 'package:fv_chat/ui/styles/app_text_styles.dart';
import 'package:fv_chat/ui/widgets/chat_bubble.dart';
import 'package:fv_chat/ui/widgets/input_row.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [];
  final ScrollController _scrollController = ScrollController();
  final String _mockResponse = MockData.mockResponse;

  bool _isWaitingForResponse = false;

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
                      style: AppTextStyles.backgoundHint,
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
            child: InputRow(
              controller: _messageController,
              onSend: _sendMessage,
              isWaitingForResponse: _isWaitingForResponse,
            ),
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
}
