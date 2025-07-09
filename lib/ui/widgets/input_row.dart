import 'package:flutter/material.dart';
import 'package:fv_chat/ui/styles/app_colors.dart';
import 'package:fv_chat/ui/styles/app_input_styles.dart';
import 'package:fv_chat/ui/styles/app_text_styles.dart';
import 'package:fv_chat/ui/widgets/cyrcle_button.dart';

class InputRow extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;
  final bool isWaitingForResponse;

  const InputRow(
      {super.key,
      required this.controller,
      required this.onSend,
      required this.isWaitingForResponse});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: AppColors.grey600,
        border: Border(
          top: BorderSide(
            color: AppColors.grey400,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 45,
              child: TextField(
                controller: controller,
                decoration: AppInputStyles.defaultInput(
                  hintText: 'Enter a message...',
                ),
                style: AppTextStyles.body1.copyWith(
                  color: AppColors.white,
                ),
                maxLines: 1,
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => onSend(),
              ),
            ),
          ),
          const SizedBox(width: 12),
          CircleButton(
            onPressed: isWaitingForResponse ? null : onSend,
            icon: Icons.send,
          ),
        ],
      ),
    );
  }
}
