import 'package:fv_chat/data/entities/chat_message.dart';

abstract class DataRepository {
  Future<ChatMessage> getNextMessage();
}
