import 'package:flutter/material.dart';
import 'package:fv_chat/ui/styles/app_button_styles.dart';

class SmallButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Icon icon;

  const SmallButton({
    super.key,
    required this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: icon,
      style: AppButtonStyles.smallButtonStyle,
    );
  }
}
