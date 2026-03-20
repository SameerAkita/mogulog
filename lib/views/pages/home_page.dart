import 'package:flutter/material.dart';
import 'package:mogulog/data/daily_nutrition_data.dart';
import 'package:mogulog/theme/app_colors.dart';
import 'package:mogulog/widgets/home/macro_widget.dart';
import 'package:mogulog/widgets/home/recent_upload_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: FractionallySizedBox(
          widthFactor: 0.9,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'mogulog',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 36,
                      color: AppColors.darkbrown,
                    ),
                  ),
                  Icon(Icons.notifications_none_rounded, size: 36),
                ],
              ),
              SizedBox(height: 8),

              Expanded(
                flex: 2,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${DailyNutritionData.caloriesLeft}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 48,
                                    color: AppColors.orange,
                                  ),
                                ),
                                Text(
                                  'calories left',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 100.0,
                              width: 100.0,
                              child: Icon(
                                Icons.catching_pokemon_rounded,
                                size: 100,
                                color: AppColors.orange,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        LinearProgressIndicator(
                          value: DailyNutritionData.calorieProgress,
                          color: AppColors.orange,
                          backgroundColor: AppColors.orangeAccent,
                          borderRadius: BorderRadius.circular(15),
                          minHeight: 8,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8),
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: MacroWidget(
                        amount: '${DailyNutritionData.proteinLeft}g',
                        title: 'Protein',
                        value: DailyNutritionData.proteinProgress,
                        color: AppColors.protein,
                        icon: Icons.egg_alt,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: MacroWidget(
                        amount: '${DailyNutritionData.fatsLeft}g',
                        title: 'Fats',
                        value: DailyNutritionData.fatsProgress,
                        color: AppColors.fats,
                        icon: Icons.water_drop,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: MacroWidget(
                        amount: '${DailyNutritionData.carbsLeft}g',
                        title: 'Carbs',
                        value: DailyNutritionData.carbsProgress,
                        color: AppColors.carbs,
                        icon: Icons.cookie,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Recently Added',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 8),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            RecentUploadWidget(
                              title: 'Oyakodon',
                              image: 'assets/images/oyakodon.jpg',
                              calories: 800,
                              protein: 30,
                              fats: 20,
                              carbs: 50,
                              time: '12:00',
                            ),
                            RecentUploadWidget(
                              title: 'Oyakodon',
                              image: 'assets/images/oyakodon.jpg',
                              calories: 800,
                              protein: 30,
                              fats: 20,
                              carbs: 50,
                              time: '12:00',
                            ),
                            RecentUploadWidget(
                              title: 'Oyakodon',
                              image: 'assets/images/oyakodon.jpg',
                              calories: 800,
                              protein: 30,
                              fats: 20,
                              carbs: 50,
                              time: '12:00',
                            ),
                          ],
                        ),
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
