import 'package:flutter/material.dart';

class OnboardingNextButton extends StatelessWidget {
  final PageController pageController;

  const OnboardingNextButton({super.key, required this.pageController});

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
