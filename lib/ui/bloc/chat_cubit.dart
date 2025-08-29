
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fv_chat/domain/entities/chat_message.dart';
import 'package:fv_chat/domain/repository/ai_repository.dart';
import 'package:fv_chat/ui/bloc/chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final AIRepository _repository;

  ChatCubit({required AIRepository repository})
      : _repository = repository,
        super(ChatState());

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
      errorMessage: null,
    ));

    try {
      final botMessage =
          await _repository.getNextMessage([...state.messages, userMessage]);
      emit(state.copyWith(
        messages: [...state.messages, botMessage],
        isLoading: false,
      ));
    } catch (e) {
      final String errorMessage = _getErrorMessage(e);

      final updatedMessages = List<ChatMessage>.from(state.messages);
      ChatMessage? lastUser;
      if (updatedMessages.isNotEmpty && updatedMessages.last.isUser) {
        lastUser = updatedMessages.removeLast();
      }

      emit(state.copyWith(
        messages: updatedMessages,
        isLoading: false,
        errorMessage: errorMessage,
        lastFailedMessage: lastUser?.text,
      ));
    }
  }

  Future<void> regenerateLast() async {
    if (state.isLoading || state.messages.isEmpty) return;

    final messages = List<ChatMessage>.from(state.messages);

    ChatMessage? oldBotMessage;
    if (!messages.last.isUser) {
      oldBotMessage = messages.removeLast();
    }

    emit(state.copyWith(
      messages: messages,
      isLoading: true,
      errorMessage: null,
    ));

    try {
      final botMessage = await _repository.getNextMessage(messages);
      emit(state.copyWith(
        messages: [...messages, botMessage],
        isLoading: false,
      ));
    } catch (e) {
      final errorMessage = _getErrorMessage(e);

      final restored = [...messages];
      if (oldBotMessage != null) {
        restored.add(oldBotMessage);
      }

      emit(state.copyWith(
        messages: restored,
        isLoading: false,
        errorMessage: errorMessage,
        lastFailedMessage: null,
      ));
    }
  }

  void clearError() {
    emit(state.copyWith(errorMessage: null));
  }

  String _getErrorMessage(dynamic error) {
    final String errorStr = error.toString().toLowerCase();

    if (errorStr.contains('network') ||
        errorStr.contains('connection') ||
        errorStr.contains('timeout') ||
        errorStr.contains('socket')) {
      return 'Check your internet connection and try again';
    } else if (errorStr.contains('unauthorized') || errorStr.contains('401')) {
      return 'Authorization error. Please check your API key';
    } else if (errorStr.contains('rate limit') || errorStr.contains('429')) {
      return 'Too many requests. Please try again in a few minutes';
    } else if (errorStr.contains('groq')) {
      return 'AI service error. Please try again later';
    } else {
      return 'An unexpected error occurred. Please try again';
    }
  }
}
