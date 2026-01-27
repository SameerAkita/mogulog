import 'package:flutter/material.dart';
import 'package:mogulog/theme/app_colors.dart';

class OnboardingStepHeightandweight extends StatefulWidget {
  const OnboardingStepHeightandweight({super.key});

  @override
  State<OnboardingStepHeightandweight> createState() =>
      _OnboardingStepHeightandweightState();
}

class _OnboardingStepHeightandweightState
    extends State<OnboardingStepHeightandweight> {
  bool metric = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Height & Weight',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
        Text('This will be used to calibrate your custom plan'),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Imperial',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: metric ? AppColors.lightgrey : Colors.black,
                    ),
                  ),
                  SizedBox(width: 8),
                  Switch(
                    value: metric,
                    onChanged: (bool value) {
                      setState(() {
                        metric = value;
                      });
                    },
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Metric',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: metric ? Colors.black : AppColors.lightgrey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
