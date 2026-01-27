import 'package:flutter/material.dart';
import 'package:mogulog/widgets/onboarding/onboarding_select_box.dart';

class OnboardingStepWorkouts extends StatefulWidget {
  const OnboardingStepWorkouts({super.key});

  @override
  State<OnboardingStepWorkouts> createState() => _OnboardingStepWorkoutsState();
}

enum WorkoutFrequency { low, medium, high }

WorkoutFrequency? selectedWorkoutFrequency;

class _OnboardingStepWorkoutsState extends State<OnboardingStepWorkouts> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'How many workouts do you do per week?',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
        Text('This will be used to calibrate your custom plan'),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OnboardingSelectBox(
                title: '0-2: Workouts now and then',
                selected: selectedWorkoutFrequency == WorkoutFrequency.low,
                onTap: () {
                  setState(() {
                    selectedWorkoutFrequency = WorkoutFrequency.low;
                  });
                },
              ),
              SizedBox(height: 16),
              OnboardingSelectBox(
                title: '3-5: Active lifestyle',
                selected: selectedWorkoutFrequency == WorkoutFrequency.medium,
                onTap: () {
                  setState(() {
                    selectedWorkoutFrequency = WorkoutFrequency.medium;
                  });
                },
              ),
              SizedBox(height: 16),
              OnboardingSelectBox(
                title: '6+: Dedicated athlete',
                selected: selectedWorkoutFrequency == WorkoutFrequency.high,
                onTap: () {
                  setState(() {
                    selectedWorkoutFrequency = WorkoutFrequency.high;
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );
    
  }
}
