import 'package:flutter/material.dart';
import 'package:mogulog/widgets/analytics/calories_widget.dart';
import 'package:mogulog/widgets/analytics/nutrients_widget.dart';
import 'package:mogulog/widgets/analytics/weight_widget.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({super.key});

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  late List<int> tempCalories = [1900, 2100, 2500, 1700, 2000, 1800, 2200];
  late int tempGoalCalories = 2000;
  late List<double> caloriesPercentage = tempCalories
      .map((c) => (c / tempGoalCalories))
      .toList();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: FractionallySizedBox(
          widthFactor: 0.95,
          child: Column(
            children: [
              WeightWidget(),
              SizedBox(height: 12),
              CaloriesWidget(
                calories: tempCalories,
                goalCalories: tempGoalCalories,
                caloriesPercentage: caloriesPercentage,
              ),
              SizedBox(height: 12),
              NutrientsWidget(),
              SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
