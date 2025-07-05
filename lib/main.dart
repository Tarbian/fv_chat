import 'package:flutter/material.dart';
import 'package:fv_chat/common/styles/app_colors.dart';
import 'package:fv_chat/pages/chat_page.dart';

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
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: AppColors.neon,
          selectionColor: AppColors.neonSade,
          selectionHandleColor: AppColors.neon,
        ),
      ),
      home: const ChatPage(),
    );
  }
}
