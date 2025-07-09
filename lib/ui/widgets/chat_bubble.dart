import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:fv_chat/ui/styles/app_colors.dart';
import 'package:fv_chat/ui/styles/app_text_styles.dart';
import 'package:url_launcher/url_launcher.dart';

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
        child: MarkdownBody(
          data: message,
          onTapLink: (text, href, title) async {
            if (href == null) return;

            final uri = Uri.tryParse(href);
            if (uri == null) {
              debugPrint("⚠️ Invalid URL: $href");
              return;
            }

            try {
              final launched = await launchUrl(
                uri,
                mode: LaunchMode.externalApplication,
              );

              if (!launched) {
                debugPrint("❌ Error: $href");
              }
            } catch (e) {
              debugPrint("❌ Some error: $e");
            }
          },
          styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
            p: AppTextStyles.body1.copyWith(
              color: isUser ? AppColors.darkGrey800 : AppColors.white,
            ),
            code: AppTextStyles.code,
            codeblockDecoration: BoxDecoration(
              color: AppColors.grey600.withOpacity(0.4),
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                width: 1,
              ),
            ),
            blockquoteDecoration: BoxDecoration(
              color: AppColors.grey400.withOpacity(0.4),
              border: const Border(
                left: BorderSide(
                  color: AppColors.neon,
                  width: 2,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
