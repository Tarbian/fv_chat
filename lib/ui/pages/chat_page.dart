import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fv_chat/model/entities/chat_message.dart';
import 'package:fv_chat/model/entities/mock_data.dart';
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
              child: _messages.isEmpty
                  ? const Center(
                      child: Text(
                        'Ask something!',
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
            InputRow(
              controller: _messageController,
              onSend: _sendMessage,
              isWaitingForResponse: _isWaitingForResponse,
            ),
          ],
        ),
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

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
  }

  void _regenerateResponse(List<ChatMessage> messages) {
    if (_isWaitingForResponse || messages.isEmpty) return;

    if (messages.isNotEmpty && !messages.last.isUser) {
      setState(() => messages.removeLast());
    }

    setState(() => _isWaitingForResponse = true);

    Future.delayed(const Duration(seconds: 1), () {
      final botMessage = ChatMessage(
        text: _mockResponse,
        isUser: false,
        timestamp: DateTime.now(),
      );

      setState(() {
        messages.add(botMessage);
        _isWaitingForResponse = false;
      });

      _scrollToBottom();
    });
  }

  Widget _buildMessageBubble(ChatMessage message) {
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
                  onPressed: () => _regenerateResponse(_messages),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
