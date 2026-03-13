import 'package:flutter/material.dart';
import 'package:mogulog/theme/app_colors.dart';

class NutrientsGraphBarWidget extends StatelessWidget {
  final String day;
  final double proteinCalories;
  final double fatsCalories;
  final double carbsCalories;
  final double totalCalories;
  final double maxCalories;

  const NutrientsGraphBarWidget({
    super.key,
    required this.day,
    required this.proteinCalories,
    required this.fatsCalories,
    required this.carbsCalories,
    required this.totalCalories,
    required this.maxCalories,
  });

  final double radiusSize = 7;

  @override
  Widget build(BuildContext context) {
    final totalPercent = maxCalories == 0
        ? 0.0
        : (totalCalories / maxCalories).clamp(0.0, 1.0);
    final macroTotal = proteinCalories + fatsCalories + carbsCalories;

    final proteinFlex = proteinCalories <= 0 ? 0 : proteinCalories.round();
    final fatsFlex = fatsCalories <= 0 ? 0 : fatsCalories.round();
    final carbsFlex = carbsCalories <= 0 ? 0 : carbsCalories.round();

    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.lightgrey,
                      borderRadius: BorderRadius.circular(radiusSize),
                    ),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: FractionallySizedBox(
                        heightFactor: totalPercent,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(radiusSize),
                          child: macroTotal == 0
                              ? const SizedBox.expand()
                              : Column(
                                  children: [
                                    if (proteinFlex > 0)
                                      Expanded(
                                        flex: proteinFlex,
                                        child: Container(
                                          color: AppColors.protein,
                                        ),
                                      ),
                                    if (fatsFlex > 0)
                                      Expanded(
                                        flex: fatsFlex,
                                        child: Container(color: AppColors.fats),
                                      ),
                                    if (carbsFlex > 0)
                                      Expanded(
                                        flex: carbsFlex,
                                        child: Container(
                                          color: AppColors.carbs,
                                        ),
                                      ),
                                  ],
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Text(day, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
