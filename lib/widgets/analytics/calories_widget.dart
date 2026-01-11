import 'package:flutter/material.dart';
import 'package:mogulog/theme/app_colors.dart';
import 'package:mogulog/widgets/analytics/calories_graph_bar_widget.dart';

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
                          CaloriesGraphBarWidget(day: 'S'),
                          SizedBox(width: 8),
                          CaloriesGraphBarWidget(day: 'M'),
                          SizedBox(width: 8),
                          CaloriesGraphBarWidget(day: 'T'),
                          SizedBox(width: 8),
                          CaloriesGraphBarWidget(day: 'W'),
                          SizedBox(width: 8),
                          CaloriesGraphBarWidget(day: 'T'),
                          SizedBox(width: 8),
                          CaloriesGraphBarWidget(day: 'F'),
                          SizedBox(width: 8),
                          CaloriesGraphBarWidget(day: 'S'),
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
