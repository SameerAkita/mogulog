import 'package:flutter/material.dart';
import 'package:mogulog/theme/app_colors.dart';

class NutrientsGraphBarWidget extends StatelessWidget {
  final String day;
  final double proteinRatio;
  final double fatsRatio;
  final double carbsRatio;

  const NutrientsGraphBarWidget({
    super.key,
    required this.day,
    required this.proteinRatio,
    required this.fatsRatio,
    required this.carbsRatio,
  });

  final double radiusSize = 7;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.lightgrey,
                borderRadius: BorderRadius.circular(radiusSize),
              ),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  FractionallySizedBox(
                    heightFactor: 1,
                    alignment: Alignment.topCenter,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(radiusSize),
                          bottom: Radius.circular(radiusSize),
                        ),
                        color: AppColors.protein,
                      ),
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: 0.66,
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(radiusSize),
                        ),
                        color: AppColors.fats,
                      ),
                    ),
                  ),

                  FractionallySizedBox(
                    heightFactor: 0.33,
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(radiusSize),
                        ),
                        color: AppColors.carbs,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Text(day, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
