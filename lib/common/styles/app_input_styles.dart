import 'package:flutter/material.dart';
import 'package:fv_chat/common/styles/app_colors.dart';
import 'package:fv_chat/common/styles/app_text_styles.dart';

abstract class AppInputStyles {
  static InputDecoration defaultInput({String? hintText}) => InputDecoration(
        hintText: hintText,
        hintStyle: AppTextStyles.inputHint,
        filled: true,
        fillColor: AppColors.grey400,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: AppColors.neon,
            width: 1,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      );

  static InputDecoration errorInput({String? hintText, String? errorText}) =>
      InputDecoration(
        hintText: hintText,
        hintStyle: AppTextStyles.inputHint,
        errorText: errorText,
        errorStyle: const TextStyle(
          color: AppColors.alertRed,
          fontSize: 12,
        ),
        filled: true,
        fillColor: AppColors.grey400,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: AppColors.alertRed,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: AppColors.alertRed,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: AppColors.alertRed,
            width: 1,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      );
}
