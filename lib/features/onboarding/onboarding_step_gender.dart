import 'package:flutter/material.dart';

class OnboardingStepGender extends StatefulWidget {
  final PageController pageController;
  const OnboardingStepGender({super.key, required this.pageController});

  @override
  State<OnboardingStepGender> createState() => _OnboardingStepGenderState();
}

enum Gender { male, female, other }

class _OnboardingStepGenderState extends State<OnboardingStepGender> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Choose your Gender',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
        Text('This will be used to calibrate your custom plan'),

      ],
    );
  }
}
