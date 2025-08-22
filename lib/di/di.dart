import 'package:fv_chat/data/ai_generators/base/ai_generator.dart';
import 'package:fv_chat/data/managers/dio_network_manager.dart';
import 'package:fv_chat/data/repository/ai_repository_impl.dart';
import 'package:fv_chat/ui/bloc/chat_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:fv_chat/data/ai_generators/base/groq_config.dart';
import 'package:fv_chat/data/ai_generators/groq_generator.dart';
// import 'package:fv_chat/data/ai_generators/base/ollama_config.dart';
// import 'package:fv_chat/data/ai_generators/ollama_generator.dart';

final getIt = GetIt.instance;

void setupDI() {
  getIt.registerSingleton<DioNetworkManager>(DioNetworkManager());
  
  // Ollama
  // getIt.registerSingleton<OllamaConfig>(OllamaConfig());
  // getIt.registerSingleton<AIGenerator>(OllamaGenerator(config: getIt<OllamaConfig>()));

  // Groq
  getIt.registerSingleton<GroqConfig>(GroqConfig());
  getIt.registerSingleton<AIGenerator>(GroqGenerator(
      config: getIt<GroqConfig>(), network: getIt<DioNetworkManager>()));

  getIt.registerFactory<AIRepositoryImpl>(
    () => AIRepositoryImpl(generator: getIt<AIGenerator>()),
  );
  getIt.registerFactory(() => ChatCubit(repository: getIt<AIRepositoryImpl>()));

}
