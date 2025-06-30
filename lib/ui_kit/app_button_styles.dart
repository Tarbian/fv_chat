import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

abstract class AppButtonStyles {
  /// === кнопки ===

  static ButtonStyle mainButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: AppColors.neon,
    foregroundColor: AppColors.darkGrey800,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    padding: const EdgeInsets.symmetric(
      horizontal: 24,
      vertical: 14,
    ),
    textStyle: AppTextStyles.button,
  );

  static ButtonStyle offMainButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: AppColors.grey200,
    foregroundColor: AppColors.grey600,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    padding: const EdgeInsets.symmetric(
      horizontal: 24,
      vertical: 14,
    ),
    textStyle: AppTextStyles.button,
  );

  static ButtonStyle circleButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: AppColors.neon,
    foregroundColor: AppColors.darkGrey800,
    elevation: 0,
    shape: const CircleBorder(),
    padding: const EdgeInsets.all(12),
    minimumSize: const Size(40, 40),
  );

  /// === Готові віджети ===

  static Widget mainButton({
    required String text,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: mainButtonStyle,
        child: Text(text),
      ),
    );
  }

  static Widget offMainButton({
    required String text,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: offMainButtonStyle,
        child: Text(text),
      ),
    );
  }

  static Widget circle({
    required VoidCallback onPressed,
    IconData icon = Icons.arrow_upward,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: circleButtonStyle,
      child: Icon(icon, size: 16),
    );
  }
}
