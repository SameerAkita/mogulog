import 'package:flutter/material.dart';
import 'package:mogulog/theme/app_colors.dart';
import 'package:mogulog/widgets/analytics/calories_widget.dart';
import 'package:mogulog/widgets/analytics/nutrients_widget.dart';
import 'package:mogulog/widgets/analytics/weight_widget.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({super.key});

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
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
              CaloriesWidget(),
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
