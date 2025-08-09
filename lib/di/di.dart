import 'package:fv_chat/data/ai_generators/base/ai_config.dart';
import 'package:fv_chat/data/ai_generators/base/ai_generator.dart';
import 'package:fv_chat/data/repository/ai_repository_impl.dart';
import 'package:get_it/get_it.dart';
import 'package:fv_chat/data/ai_generators/base/groq_config.dart';
import 'package:fv_chat/data/ai_generators/groq_generator.dart';
// import 'package:fv_chat/data/ai_generators/base/ollama_config.dart';
// import 'package:fv_chat/data/ai_generators/ollama_generator.dart';

final getIt = GetIt.instance;

void setupDI() {
  // Ollama
  // getIt.registerSingleton<AIConfig>(OllamaConfig());
  // getIt.registerSingleton<AIGenerator>(OllamaGenerator(config: getIt<OllamaConfig>()));

  // Groq
  getIt.registerSingleton<AIConfig>(GroqConfig());
  getIt.registerSingleton<AIGenerator>(GroqGenerator(config: getIt<GroqConfig>()));

  getIt.registerFactory<AIRepositoryImpl>(
    () => AIRepositoryImpl(generator: getIt<AIGenerator>()),
  );
}
