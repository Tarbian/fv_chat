import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fv_chat/domain/entities/chat_message.dart';
import 'package:fv_chat/data/repository/ai_repository_impl.dart';
import 'package:fv_chat/di/di.dart';

class ChatState {
  final List<ChatMessage> messages;
  final bool isLoading;

  const ChatState({
    this.messages = const [],
    this.isLoading = false,
  });

  ChatState copyWith({
    List<ChatMessage>? messages,
    bool? isLoading,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class ChatCubit extends Cubit<ChatState> {
  final AIRepositoryImpl _repository = getIt<AIRepositoryImpl>();

  ChatCubit() : super(const ChatState());

  Future<void> sendMessage(String text) async {
    if (state.isLoading || text.trim().isEmpty) return;

    final userMessage = ChatMessage(
      text: text.trim(),
      isUser: true,
      timestamp: DateTime.now(),
    );

    emit(state.copyWith(
      messages: [...state.messages, userMessage],
      isLoading: true,
    ));

    try {
      final botMessage = await _repository.getNextMessage(state.messages + [userMessage]);

      emit(state.copyWith(
        messages: [...state.messages, botMessage],
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> regenerateLast() async {
    if (state.isLoading || state.messages.isEmpty) return;

    var messages = List<ChatMessage>.from(state.messages);
    if (!messages.last.isUser) {
      messages.removeLast();
    }

    emit(state.copyWith(messages: messages, isLoading: true));

    try {
      final botMessage = await _repository.getNextMessage(messages);
      emit(state.copyWith(messages: [...messages, botMessage], isLoading: false));
    } catch (_) {
      emit(state.copyWith(isLoading: false));
    }
  }
}
