import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'ai_config.dart';

class GroqConfig implements AIConfig {
  @override
  String get apiKey => dotenv.env['GROQ_API_KEY'] ?? '';

  @override
  String get model => 'gemma2-9b-it';

  @override
  int get maxTokens => 128;

  String get baseUrl => 'https://api.groq.com/openai/v1/chat/completions';
}
