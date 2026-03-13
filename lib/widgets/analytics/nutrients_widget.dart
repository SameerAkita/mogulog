import 'package:flutter/material.dart';
import 'package:mogulog/theme/app_colors.dart';
import 'package:mogulog/widgets/analytics/nutrients_graph_bar_widget.dart';

class NutrientDayData {
  final String day;
  final double proteinGrams;
  final double fatsGrams;
  final double carbsGrams;

  const NutrientDayData({
    required this.day,
    required this.proteinGrams,
    required this.fatsGrams,
    required this.carbsGrams,
  });

  double get proteinCalories => proteinGrams * 4;
  double get fatsCalories => fatsGrams * 9;
  double get carbsCalories => carbsGrams * 4;
  double get totalCalories => proteinCalories + fatsCalories + carbsCalories;
}

class NutrientsWidget extends StatelessWidget {
  const NutrientsWidget({super.key});

  List<NutrientDayData> get weeklyData => const [
    NutrientDayData(
      day: 'S',
      proteinGrams: 110,
      fatsGrams: 62,
      carbsGrams: 180,
    ),
    NutrientDayData(
      day: 'M',
      proteinGrams: 125,
      fatsGrams: 58,
      carbsGrams: 210,
    ),
    NutrientDayData(
      day: 'T',
      proteinGrams: 132,
      fatsGrams: 70,
      carbsGrams: 240,
    ),
    NutrientDayData(day: 'W', proteinGrams: 98, fatsGrams: 52, carbsGrams: 165),
    NutrientDayData(
      day: 'T',
      proteinGrams: 120,
      fatsGrams: 61,
      carbsGrams: 205,
    ),
    NutrientDayData(
      day: 'F',
      proteinGrams: 105,
      fatsGrams: 55,
      carbsGrams: 190,
    ),
    NutrientDayData(
      day: 'S',
      proteinGrams: 128,
      fatsGrams: 67,
      carbsGrams: 220,
    ),
  ];

  double get averageCalories =>
      weeklyData.fold(0.0, (sum, day) => sum + day.totalCalories) /
      weeklyData.length;

  double get maxCalories => weeklyData
      .map((day) => day.totalCalories)
      .reduce((current, next) => current > next ? current : next);

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
                'Nutrients',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 6),
              Expanded(
                child: Row(
                  children: [
                    SizedBox(
                      width: 104,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${averageCalories.toStringAsFixed(0)} cal',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const Text(
                            'avg intake',
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 16),
                          const _LegendRow(
                            color: AppColors.protein,
                            label: 'Protein',
                          ),
                          const SizedBox(height: 8),
                          const _LegendRow(
                            color: AppColors.fats,
                            label: 'Fats',
                          ),
                          const SizedBox(height: 8),
                          const _LegendRow(
                            color: AppColors.carbs,
                            label: 'Carbs',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 18),
                    Expanded(
                      child: Row(
                        children:
                            weeklyData
                                .expand(
                                  (day) => [
                                    NutrientsGraphBarWidget(
                                      day: day.day,
                                      proteinCalories: day.proteinCalories,
                                      fatsCalories: day.fatsCalories,
                                      carbsCalories: day.carbsCalories,
                                      totalCalories: day.totalCalories,
                                      maxCalories: maxCalories,
                                    ),
                                    const SizedBox(width: 8),
                                  ],
                                )
                                .toList()
                              ..removeLast(),
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

class _LegendRow extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendRow({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
