import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

abstract class AppButtonStyles {
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
    disabledBackgroundColor: AppColors.grey200,
    disabledForegroundColor: AppColors.grey600,
  );

  static ButtonStyle circleButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: AppColors.neon,
    foregroundColor: AppColors.darkGrey800,
    elevation: 0,
    shape: const CircleBorder(),
    padding: const EdgeInsets.all(12),
    minimumSize: const Size(40, 40),
    disabledBackgroundColor: AppColors.grey200,
    disabledForegroundColor: AppColors.grey600,
  );

  static ButtonStyle smallButtonStyle = ElevatedButton.styleFrom(
    iconColor: AppColors.lightGrey,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    visualDensity: VisualDensity.compact,
  );
}
