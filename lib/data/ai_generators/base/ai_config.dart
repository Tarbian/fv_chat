import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class AIConfig {
  static String get groqApiKey => dotenv.env['GROQ_API_KEY'] ?? '';
  static const defaultOllamamodel = 'qwen2.5:0.5b';
  static const defaultMaxTokens = 128;
  static const defaultOllamaPort = '11434';
  static const defaultOllamaIP = 'localhost';
  static const defaultGroqmodel = 'qwen/qwen3-32b';
}
