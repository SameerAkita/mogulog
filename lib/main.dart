import 'package:flutter/material.dart';
import 'package:mogulog/theme/app_colors.dart';
import 'package:mogulog/views/widget_tree.dart';

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
        cardTheme: CardThemeData(color: AppColors.offwhite),
        scaffoldBackgroundColor: AppColors.offwhite,
      ),
      // home: WidgetTree(),
      home: WidgetTree(),
    );
  }
}
