import 'package:flutter/material.dart';
import 'package:mogulog/features/welcome/welcome_page.dart';
import 'package:mogulog/theme/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        cardTheme: CardThemeData(color: Colors.white),
        scaffoldBackgroundColor: Colors.white,
        textTheme: ThemeData.light().textTheme.apply(
          bodyColor: AppColors.darkbrown,
          displayColor: AppColors.darkbrown,
        ),
      ),
      home: const WelcomePage(),
    );
  }
}
