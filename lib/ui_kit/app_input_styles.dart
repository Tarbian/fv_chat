import 'package:flutter/material.dart';

abstract class AppInputStyles {
  /// === стилі полів вводу ===
  
  /// Звичайне поле вводу
  static InputDecoration defaultInput({String? hintText}) => InputDecoration(
    hintText: hintText,
    hintStyle: const TextStyle(
      color: Color(0xFF65666A), // grey200
      fontSize: 14,
    ),
    filled: true,
    fillColor: const Color(0xFF3D3F46), // grey400
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        color: Color(0xFFD3F686), // neon
        width: 1,
      ),
    ),
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 14,
    ),
  );

  /// Поле з помилкою
  static InputDecoration errorInput({String? hintText, String? errorText}) => InputDecoration(
    hintText: hintText,
    hintStyle: const TextStyle(
      color: Color(0xFF65666A), // grey200
      fontSize: 14,
    ),
    errorText: errorText,
    errorStyle: const TextStyle(
      color: Color(0xFFF64848), // alertRed
      fontSize: 12,
    ),
    filled: true,
    fillColor: const Color(0xFF3D3F46), // grey400
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        color: Color(0xFFF64848), // alertRed
        width: 1,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        color: Color(0xFFF64848), // alertRed
        width: 1,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        color: Color(0xFFF64848), // alertRed
        width: 1,
      ),
    ),
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 14,
    ),
  );

  /// Активне поле (з фокусом)
  static InputDecoration activeInput({String? hintText}) => InputDecoration(
    hintText: hintText,
    hintStyle: const TextStyle(
      color: Color(0xFF65666A), // grey200
      fontSize: 14,
    ),
    filled: true,
    fillColor: const Color(0xFF3D3F46), // grey400
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        color: Color(0xFFD3F686), // neon
        width: 2,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        color: Color(0xFFD3F686), // neon
        width: 2,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        color: Color(0xFFD3F686), // neon
        width: 2,
      ),
    ),
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 14,
    ),
  );

  /// === Стилі тексту для полів ===
  
  static const TextStyle inputTextStyle = TextStyle(
    color: Color(0xFFFFFFFF), // white
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle placeholderStyle = TextStyle(
    color: Color(0xFF65666A), // grey200
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );
}