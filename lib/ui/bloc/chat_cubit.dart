import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fv_chat/domain/entities/chat_message.dart';
import 'package:fv_chat/domain/repository/ai_repository.dart';
import 'package:fv_chat/ui/bloc/chat_state.dart';


class ChatCubit extends Cubit<ChatState> {
  final AIRepository _repository;

  ChatCubit({required AIRepository repository})
      : _repository = repository,
        super(const ChatState());


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
