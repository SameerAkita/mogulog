import 'package:flutter/material.dart';
import 'package:mogulog/widgets/onboarding/onboarding_select_box.dart';

class OnboardingStepGender extends StatefulWidget {
  final PageController pageController;
  const OnboardingStepGender({super.key, required this.pageController});

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
        OnboardingSelectBox(
          title: 'Male',
          selected: selectedGender == Gender.male,
          onTap: () {
            setState(() {
              selectedGender = Gender.male;
            });
          },
        ),
        OnboardingSelectBox(
          title: 'Female',
          selected: selectedGender == Gender.female,
          onTap: () {
            setState(() {
              selectedGender = Gender.female;
            });
          },
        ),
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
    );
  }
}
