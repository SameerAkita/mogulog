import 'package:flutter/material.dart';

class OnboardingContinueButton extends StatelessWidget {
  final PageController pageController;

  const OnboardingContinueButton({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        pageController.nextPage(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      },
      child: const Text('Continue'),
    );
  }
}
