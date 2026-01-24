import 'package:flutter/material.dart';

class OnboardingStepWorkouts extends StatelessWidget {
  const OnboardingStepWorkouts({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'How many workouts do you do per week?',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
        Text('This will be used to calibrate your custom plan'),
        
      ],
    );;
  }
}