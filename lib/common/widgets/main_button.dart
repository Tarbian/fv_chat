import 'package:flutter/material.dart';
import 'package:fv_chat/common/styles/app_button_styles.dart';

class MainButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const MainButton({
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
        style: AppButtonStyles.mainButtonStyle,
        child: Text(text),
      ),
    );
  }
}
