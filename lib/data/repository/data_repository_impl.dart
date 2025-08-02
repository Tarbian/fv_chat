import 'package:fv_chat/data/entities/chat_message.dart';
import 'package:fv_chat/data/repository/data_repository.dart';
import 'package:fv_chat/data/generator/ai_generator.dart';

class DataRepositoryImpl implements DataRepository {
  final List<ChatMessage> chatHistory;
  final AIGenerator generator;

  DataRepositoryImpl({
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
