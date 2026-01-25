import 'package:flutter/material.dart';

class OnboardingSelectBox extends StatelessWidget {
  final String title;
  final bool selected;
  final VoidCallback onTap;

  const OnboardingSelectBox({super.key, required this.title, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(child: GestureDetector(),);
  }
}