import 'package:flutter/material.dart';
import 'package:fv_chat/ui/styles/app_colors.dart';
import 'package:fv_chat/ui/pages/chat_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: false,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.neon,
          brightness: Brightness.dark,
        ),
      ),
      home: const ChatPage(),
    );
  }
}
