import 'package:flutter/material.dart';
import 'package:mogulog/features/onboarding/onboarding_page.dart';
import 'package:mogulog/features/welcome/welcome_page.dart';
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
      ),
      // home: WidgetTree(),
      home: WelcomePage(),
    );
  }
}
