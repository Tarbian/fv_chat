import 'package:dio/dio.dart';
import 'package:fv_chat/data/ai_config.dart';
import 'package:fv_chat/data/generator/ai_generator.dart';

class OllamaGenerator extends AIGenerator {
  final String model;
  final String ollamaUrl;
  final int maxTokens;
  final Dio _dio;

  OllamaGenerator({
    required this.model,
    required this.ollamaUrl,
    this.maxTokens = AIConfig.defaultMaxTokens,
    Dio? dio,
  }) : _dio = dio ?? Dio();

  @override
  Future<String> sendChatHistory(List<Map<String, String>> messages) async {
    try {
      final response = await _dio.post(
        ollamaUrl,
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
