import 'package:flutter/material.dart';
import 'package:mogulog/widgets/onboarding/onboarding_continue_button.dart';

class OnboardingStepWelcome extends StatelessWidget {
  final PageController pageController;
  const OnboardingStepWelcome({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Calorie tracking'),
        Text('made easy'),
        SizedBox(
          width: double.infinity,
          child: OnboardingContinueButton(pageController: pageController),
        ),
        InkWell(
          onTap: () {},
          child: RichText(
            text: TextSpan(
              // The default text style for the entire RichText
              style: DefaultTextStyle.of(context).style,
              children: const <TextSpan>[
                TextSpan(text: 'Already have an account? '),
                TextSpan(
                  text: 'Sign in',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ), // Specific style for this span
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
