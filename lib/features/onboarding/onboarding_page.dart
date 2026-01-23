import 'package:flutter/material.dart';
import 'package:mogulog/features/onboarding/onboarding_step_welcome.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Container(
            color: Colors.red,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                  );
                },
                child: const Text('Next'),
              ),
            ),
          ),
          OnboardingStepWelcome(pageController: _pageController),
          Container(color: Colors.green),
        ],
      ),
    );
  }
}
