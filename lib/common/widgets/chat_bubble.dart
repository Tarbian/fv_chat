import 'package:flutter/material.dart';
import 'package:fv_chat/common/styles/app_colors.dart';
import 'package:fv_chat/common/styles/app_text_styles.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isUser;
  final Color backgroundColor;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isUser,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.85,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          message,
          style: AppTextStyles.body1.copyWith(
            color: isUser ? AppColors.darkGrey800 : AppColors.white,
          ),
        ),
      ),
    );
  }
}
