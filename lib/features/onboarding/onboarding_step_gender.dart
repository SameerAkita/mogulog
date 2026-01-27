import 'package:flutter/material.dart';
import 'package:mogulog/widgets/onboarding/onboarding_select_box.dart';

class OnboardingStepGender extends StatefulWidget {
  const OnboardingStepGender({super.key});

  @override
  State<OnboardingStepGender> createState() => _OnboardingStepGenderState();
}

enum Gender { male, female, other }

Gender? selectedGender;

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
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OnboardingSelectBox(
                title: 'Male',
                selected: selectedGender == Gender.male,
                onTap: () {
                  setState(() {
                    selectedGender = Gender.male;
                  });
                },
              ),
              SizedBox(height: 16),
              OnboardingSelectBox(
                title: 'Female',
                selected: selectedGender == Gender.female,
                onTap: () {
                  setState(() {
                    selectedGender = Gender.female;
                  });
                },
              ),
              SizedBox(height: 16),
              OnboardingSelectBox(
                title: 'Other',
                selected: selectedGender == Gender.other,
                onTap: () {
                  setState(() {
                    selectedGender = Gender.other;
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
