import 'package:fv_chat/domain/entities/chat_message.dart';
import 'package:fv_chat/domain/repository/ai_repository.dart';
import 'package:fv_chat/data/ai_generators/base/ai_generator.dart';

class AIRepositoryImpl implements AIRepository {
  final List<ChatMessage> chatHistory;
  final AIGenerator generator;

  AIRepositoryImpl({
    required this.chatHistory,
    required this.generator,
  });

  @override
  Future<ChatMessage> getNextMessage() async {
    final messages = chatHistory.map((msg) {
      return {
        'role': msg.isUser ? 'user' : 'assistant',
        'content': msg.text,
      };
    }).toList();

    final responseText = await generator.sendChatHistory(messages);

    return ChatMessage(
      text: responseText,
      isUser: false,
      timestamp: DateTime.now(),
    );
  }
}
