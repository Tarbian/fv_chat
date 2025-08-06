import 'package:fv_chat/domain/entities/chat_message.dart';
import 'package:fv_chat/domain/repository/ai_repository.dart';
import 'package:fv_chat/data/managers/mock_data_manager.dart';

class MockRepositoryImpl implements AIRepository {
  final MockDataManager _mockDataManager;

  MockRepositoryImpl({
    MockDataManager? mockDataManager,
  }) : _mockDataManager = mockDataManager ?? MockDataManager();

  @override
  Future<ChatMessage> getNextMessage() async {
    final mockResponse = _mockDataManager.getMockResponse();

    return ChatMessage(
      text: mockResponse,
      isUser: false,
      timestamp: DateTime.now(),
    );
  }
}