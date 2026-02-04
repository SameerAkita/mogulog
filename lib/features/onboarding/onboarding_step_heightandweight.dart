import 'package:flutter/material.dart';
import 'package:mogulog/theme/app_colors.dart';
import 'package:mogulog/widgets/onboarding/tile.dart';

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
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text('Height'),
                          Expanded(
                            child: ListWheelScrollView.useDelegate(
                              itemExtent: 27,
                              perspective: 0.005,
                              diameterRatio: 1.4,

                              childDelegate: ListWheelChildBuilderDelegate(
                                childCount: 181,
                                builder: (context, index) {
                                  return Tile(value: index + 60, unit: 'cm');
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text('Weight'),
                          Expanded(
                            child: ListWheelScrollView.useDelegate(
                              itemExtent: 27,
                              perspective: 0.005,
                              diameterRatio: 1.4,

                              childDelegate: ListWheelChildBuilderDelegate(
                                childCount: 311,
                                builder: (context, index) {
                                  return Tile(value: index + 50, unit: 'kg');
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
