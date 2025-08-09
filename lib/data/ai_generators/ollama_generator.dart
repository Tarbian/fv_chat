import 'package:dio/dio.dart';
import 'package:fv_chat/data/ai_generators/base/ai_config.dart';
import 'package:fv_chat/data/ai_generators/base/ai_generator.dart';
import 'package:fv_chat/data/ai_generators/base/ollama_config.dart';

class OllamaGenerator implements AIGenerator {
  final AIConfig config;
  final Dio _dio;

  OllamaGenerator({
    required this.config,
    Dio? dio,
  }) : _dio = dio ?? Dio();

  String get model => config.model;
  String get baseUrl => 'http://${(config as OllamaConfig).ip}:${(config as OllamaConfig).port}/api/chat';
  int get maxTokens => config.maxTokens;

  @override
  Future<String> sendChatHistory(List<Map<String, String>> messages) async {
    try {
      final response = await _dio.post(
        baseUrl,
        data: {
          'model': model,
          'messages': messages,
          'stream': false,
          'options': {
            'num_predict': maxTokens,
          },
        },
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        return data['message']?['content']?.trim() ?? '...';
      } else {
        throw Exception('Помилка генерації: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Помилка запиту: ${e.message}');
    }
  }
}
