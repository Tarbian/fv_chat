import 'package:flutter/material.dart';
import 'package:fv_chat/domain/entities/chat_message.dart';
import 'package:fv_chat/ui/styles/app_colors.dart';
import 'package:fv_chat/ui/widgets/chat_bubble.dart';
import 'package:fv_chat/ui/widgets/small_button.dart';

class MessageBubble extends StatelessWidget {
  final ChatMessage message;
  final VoidCallback? onCopy;
  final VoidCallback? onRegenerate;

  const MessageBubble({
    super.key,
    required this.message,
    this.onCopy,
    this.onRegenerate,
  });

  @override
  Widget build(BuildContext context) {
    final isBot = !message.isUser;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: message.isUser
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: message.isUser
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              ChatBubble(
                message: message.text,
                isUser: message.isUser,
                backgroundColor:
                    message.isUser ? AppColors.neon : AppColors.grey400,
              ),
            ],
          ),
          if (isBot)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (onCopy != null)
                  SmallButton(
                    icon: const Icon(Icons.copy),
                    onPressed: onCopy,
                  ),
                if (onRegenerate != null)
                  SmallButton(
                    icon: const Icon(Icons.refresh),
                    onPressed: onRegenerate,
                  ),
              ],
            ),
        ],
      ),
    );
  }
}
