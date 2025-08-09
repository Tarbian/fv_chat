import 'ai_config.dart';

class OllamaConfig implements AIConfig {
  @override
  String get apiKey => '';

  @override
  String get model => 'qwen2.5:0.5b';

  @override
  int get maxTokens => 128;

  String get ip => 'localhost';
  String get port => '11434';
}
