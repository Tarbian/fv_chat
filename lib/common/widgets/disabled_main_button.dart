import 'package:flutter/material.dart';
import 'package:fv_chat/common/styles/app_button_styles.dart';

class DisabledMainButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const DisabledMainButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: AppButtonStyles.disabledMainButtonStyle,
        child: Text(text),
      ),
    );
  }
}
