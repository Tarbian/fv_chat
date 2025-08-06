import 'package:dio/dio.dart';
import 'package:fv_chat/data/ai_generators/base/ai_generator.dart';
import 'package:fv_chat/data/ai_generators/base/ai_config.dart';

class GroqGenerator implements AIGenerator {
  final String apiKey;
  final String model;
  final String baseUrl;
  final Dio _dio;

  GroqGenerator({
    required this.apiKey,
    this.model = AIConfig.defaultGroqmodel,
    this.baseUrl =
        'https://api.groq.com/openai/v1/chat/completions',
    Dio? dio,
  }) : _dio = dio ?? Dio();

  @override
  Future<String> sendChatHistory(List<Map<String, String>> messages) async {
    try {
      final response = await _dio.post(
        baseUrl,
        data: {
          'model': model,
          'messages': messages,
          'temperature': 0.7,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $apiKey',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        return data['choices']?[0]?['message']?['content']?.trim() ?? '...';
      } else {
        throw Exception('Groq помилка: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Groq запит не вдався: ${e.message}');
    }
  }
}
