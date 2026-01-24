import 'package:flutter/material.dart';

class OnboardingStepGender extends StatelessWidget {
  final PageController pageController;
  const OnboardingStepGender({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Choose your Gender',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
        
      ],
    );
  }
}
