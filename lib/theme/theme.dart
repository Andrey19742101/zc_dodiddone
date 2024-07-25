import 'package:flutter/material.dart';

class DoDidDoneTheme {
  static ThemeData lightTheme = ThemeData(
    // Используем два основных цвета
    colorScheme: ColorScheme.fromSeed(
      seedColor: Color(0xFF9f7bf6), // Основной цвет #9f7bf6
      brightness: Brightness.light,
      primary: Color(0xFF9f7bf6), // Основной цвет #9f7bf6
      secondary: Color(0xFF4ceb8b), // Вторичный цвет #4ceb8b
    ),
    useMaterial3: true,
    // Добавляем стиль для кнопок
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all<TextStyle>(
          const TextStyle(color: Colors.white), // Текст кнопок белый
        ),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: const Color(0xFF9f7bf6), // Цвет выбранной иконки
      unselectedItemColor:
          const Color(0xFF4ceb8b).withOpacity(0.5), // Цвет невыбранной иконки
      backgroundColor: Colors.transparent, // Прозрачный фон
      // Убираем тень
    ),
  );
}
