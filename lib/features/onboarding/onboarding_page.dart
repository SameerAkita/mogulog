import 'package:flutter/material.dart';
import 'package:mogulog/features/onboarding/onboarding_step_gender.dart';
import 'package:mogulog/features/onboarding/onboarding_step_workouts.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  late final List<Widget> _pages;

  int _currentPage = 0;

  @override
  void initState() {
    super.initState();

    _pages = [
      OnboardingStepGender(pageController: _pageController),
      OnboardingStepWorkouts(),
    ];
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: FractionallySizedBox(
            widthFactor: 0.9,
            child: Column(
              children: [
                LinearProgressIndicator(
                  value: (_currentPage + 1) / _pages.length,
                ),
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    physics: const NeverScrollableScrollPhysics(),
                    children: _pages,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
