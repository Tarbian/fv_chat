import 'package:fv_chat/data/ai_generators/base/ai_config.dart';
import 'package:fv_chat/data/ai_generators/base/ai_generator.dart';
import 'package:fv_chat/data/ai_generators/base/ollama_config.dart';
import 'package:fv_chat/data/managers/base/network_manager.dart';

class OllamaGenerator implements AIGenerator {
  final AIConfig config;
  final NetworkManager network;

  OllamaGenerator({
    required this.config,
    required this.network,
  });

  String get model => config.model;
  String get baseUrl => 'http://${(config as OllamaConfig).ip}:${(config as OllamaConfig).port}/api/chat';
  int get maxTokens => config.maxTokens;

  @override
  Future<String> sendChatHistory(List<Map<String, String>> messages) async {
    final response = await network.post(
      baseUrl,
      data: {
        'model': model,
        'messages': messages,
        'stream': false,
        'options': {
          'num_predict': maxTokens,
        },
      },
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = response.data;
      return data['message']?['content']?.trim() ?? '...';
    } else {
      throw Exception('Помилка генерації: ${response.statusMessage}');
    }
  }
}
