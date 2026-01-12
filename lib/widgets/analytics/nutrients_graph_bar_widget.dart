import 'package:flutter/material.dart';
import 'package:mogulog/theme/app_colors.dart';

class NutrientsGraphBarWidget extends StatelessWidget {
  final String day;

  const NutrientsGraphBarWidget({super.key, required this.day});

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
              child: Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.protein,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(radiusSize),
                        ),
                      ),
                    ),
                  ),
                  Expanded(flex: 1, child: Container(color: AppColors.fats)),
                  Expanded(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.carbs,
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(radiusSize),
                        ),
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
