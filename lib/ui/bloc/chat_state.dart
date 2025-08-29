import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fv_chat/domain/entities/chat_message.dart';

part 'chat_state.freezed.dart';

@freezed
class ChatState with _$ChatState {
  factory ChatState({
    @Default([]) List<ChatMessage> messages,
    @Default(false) bool isLoading,
    @Default(null) String? errorMessage,
    @Default(null) String? lastFailedMessage,
  }) = _ChatState;
}
