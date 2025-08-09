import 'package:fv_chat/data/ai_generators/base/ai_generator.dart';
import 'package:fv_chat/data/ai_generators/base/groq_config.dart';
import 'package:fv_chat/data/managers/base/network_manager.dart';

class GroqGenerator implements AIGenerator {
  final GroqConfig config;
  final NetworkManager network;

  GroqGenerator({
    required this.config,
    required this.network,
  });

  String get apiKey => config.apiKey;
  String get model => config.model;
  String get baseUrl => config.baseUrl;

  @override
  Future<String> sendChatHistory(List<Map<String, String>> messages) async {
    final response = await network.post(
      baseUrl,
      data: {
        'model': model,
        'messages': messages,
        'temperature': 0.7,
      },
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = response.data;
      return data['choices']?[0]?['message']?['content']?.trim() ?? '...';
    } else {
      throw Exception('Groq помилка: ${response.statusMessage}');
    }
  }
}
