import 'package:flutter/material.dart';
import 'package:fv_chat/ui/styles/app_colors.dart';
import 'package:fv_chat/ui/styles/app_text_styles.dart';

abstract class AppInputStyles {
  static InputDecoration defaultInput({String? hintText}) => InputDecoration(
        hintText: hintText,
        hintStyle: AppTextStyles.inputHint,
        filled: true,
        fillColor: AppColors.grey400,
        border: _outlineInputBorder(width: 0),
        focusedBorder: _outlineInputBorder(color: AppColors.neon),
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
          fontFamily: 'SF Pro Display',
          color: AppColors.alertRed,
          fontSize: 12,
        ),
        filled: true,
        fillColor: AppColors.grey400,
        border: _outlineInputBorder(color: AppColors.alertRed),
        focusedBorder: _outlineInputBorder(color: AppColors.alertRed),
        enabledBorder: _outlineInputBorder(color: AppColors.alertRed),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      );

  static OutlineInputBorder _outlineInputBorder({
    Color? color,
    double width = 1,
  }) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: color == null
            ? BorderSide.none
            : BorderSide(
                color: color,
                width: width,
              ),
      );
}
