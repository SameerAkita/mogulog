import 'package:flutter/material.dart';

class OnboardingStepWelcome extends StatelessWidget {
  final PageController pageController;
  const OnboardingStepWelcome({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Center(
        child: ElevatedButton(
          onPressed: () {
            pageController.nextPage(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
            );
          },
          child: const Text('next'),
        ),
      ),
    );
  }
}
