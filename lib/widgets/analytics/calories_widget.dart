import 'package:flutter/material.dart';
import 'package:mogulog/theme/app_colors.dart';
import 'package:mogulog/widgets/analytics/calories_graph_bar_widget.dart';

class BarValue {
  final double base;
  final double overflow;

  const BarValue({required this.base, required this.overflow});
}

class CaloriesWidget extends StatelessWidget {
  final List<int> calories;
  final int goalCalories;
  final List<double> caloriesPercentage;
  const CaloriesWidget({
    super.key,
    required this.calories,
    required this.goalCalories,
    required this.caloriesPercentage,
  });

  List<BarValue> get bars {
    return caloriesPercentage.map((p) {
      return BarValue(
        base: p.clamp(0.0, 1.0),
        overflow: ((p - 1.0) * 2).clamp(0.0, 1.0),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Calories',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Expanded(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 6,
                      ), // padding counteracts the circularprogressindicator's stroke width
                      child: SizedBox(
                        height: 100.0,
                        width: 100.0,
                        child: CircularProgressIndicator(
                          value: 0.8,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.black,
                          ),
                          backgroundColor: AppColors.lightgrey,
                          strokeWidth: 10,
                          strokeCap: StrokeCap.round,
                        ),
                      ),
                    ),
                    SizedBox(width: 18),
                    Expanded(
                      child: Row(
                        children: [
                          CaloriesGraphBarWidget(
                            day: 'S',
                            calories: calories[0],
                            basePercent: bars[0].base,
                            overflowPercent: bars[0].overflow,
                          ),
                          SizedBox(width: 8),
                          CaloriesGraphBarWidget(
                            day: 'M',
                            calories: calories[1],
                            basePercent: bars[1].base,
                            overflowPercent: bars[1].overflow,
                          ),
                          SizedBox(width: 8),
                          CaloriesGraphBarWidget(
                            day: 'T',
                            calories: calories[2],
                            basePercent: bars[2].base,
                            overflowPercent: bars[2].overflow,
                          ),
                          SizedBox(width: 8),
                          CaloriesGraphBarWidget(
                            day: 'W',
                            calories: calories[3],
                            basePercent: bars[3].base,
                            overflowPercent: bars[3].overflow,
                          ),
                          SizedBox(width: 8),
                          CaloriesGraphBarWidget(
                            day: 'T',
                            calories: calories[4],
                            basePercent: bars[4].base,
                            overflowPercent: bars[4].overflow,
                          ),
                          SizedBox(width: 8),
                          CaloriesGraphBarWidget(
                            day: 'F',
                            calories: calories[5],
                            basePercent: bars[5].base,
                            overflowPercent: bars[5].overflow,
                          ),
                          SizedBox(width: 8),
                          CaloriesGraphBarWidget(
                            day: 'S',
                            calories: calories[6],
                            basePercent: bars[6].base,
                            overflowPercent: bars[6].overflow,
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
      ),
    );
  }
}
