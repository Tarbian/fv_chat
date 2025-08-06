import 'package:fv_chat/domain/entities/chat_message.dart';

abstract class AIRepository {
  Future<ChatMessage> getNextMessage();
}