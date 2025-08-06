import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fv_chat/data/ai_generators/base/ai_config.dart';
import 'package:fv_chat/domain/entities/chat_message.dart';
import 'package:fv_chat/data/ai_generators/groq_generator.dart';
import 'package:fv_chat/ui/styles/app_colors.dart';
import 'package:fv_chat/ui/styles/app_text_styles.dart';
import 'package:fv_chat/ui/widgets/chat_bubble.dart';
import 'package:fv_chat/ui/widgets/input_row.dart';
import 'package:fv_chat/ui/widgets/small_button.dart';
import 'package:fv_chat/data/repository/ai_repository_impl.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [];
  final ScrollController _scrollController = ScrollController();

  late final AIRepositoryImpl _repository;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    final groq = GroqGenerator(apiKey: AIConfig.groqApiKey);
    
    _repository = AIRepositoryImpl(
      chatHistory: _messages,
      generator: groq,
    );
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
              isWaitingForResponse: _isLoading,
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

  Future<void> _sendMessage() async {
    if (_isLoading || _messageController.text.trim().isEmpty) return;

    final inputText = _messageController.text.trim();

    final userMessage = ChatMessage(
      text: inputText,
      isUser: true,
      timestamp: DateTime.now(),
    );

    setState(() {
      _messages.add(userMessage);
      _isLoading = true;
    });

    _messageController.clear();
    _scrollToBottom();

    try {
      final botMessage = await _repository.getNextMessage();

      setState(() {
        _messages.add(botMessage);
        _isLoading = false;
      });

      _scrollToBottom();
    } catch (e) {
      setState(() {
        _messages.removeLast();
        _messageController.text = inputText;
        _isLoading = false;
      });

      _scrollToBottom();
      _showError(e.toString());
    }
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

  void _regenerateResponse(List<ChatMessage> messages) async {
    if (_isLoading || messages.isEmpty) return;

    if (!messages.last.isUser) {
      setState(() => messages.removeLast());
    }

    setState(() => _isLoading = true);

    try {
      final botMessage = await _repository.getNextMessage();

      setState(() {
        messages.add(botMessage);
        _isLoading = false;
      });

      _scrollToBottom();
    } catch (e) {
      setState(() => _isLoading = false);
      _showError(e.toString());
    }
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: AppColors.alertRed),
    );
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
