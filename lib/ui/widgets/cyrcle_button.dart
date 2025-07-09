import 'package:flutter/material.dart';
import 'package:fv_chat/ui/styles/app_button_styles.dart';

class CircleButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData icon;

  const CircleButton({
    super.key,
    required this.onPressed,
    this.icon = Icons.arrow_upward,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: AppButtonStyles.circleButtonStyle,
      child: Icon(icon, size: 16),
    );
  }
}
