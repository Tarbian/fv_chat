import 'package:get_it/get_it.dart';
import 'package:fv_chat/data/ai_generators/groq_generator.dart';
import 'package:fv_chat/data/ai_generators/base/ai_config.dart';

final getIt = GetIt.instance;

void setupDI() {
  getIt.registerSingleton<GroqGenerator>(
    GroqGenerator(apiKey: AIConfig.groqApiKey),
  );
}
