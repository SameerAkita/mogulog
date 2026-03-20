class DailyNutritionData {
  static const int targetCalories = 2200;
  static const int targetProteinGrams = 140;
  static const int targetFatsGrams = 60;
  static const int targetCarbsGrams = 230;

  static const int consumedCalories = 1530;
  static const int consumedProteinGrams = 92;
  static const int consumedFatsGrams = 41;
  static const int consumedCarbsGrams = 156;

  static int get caloriesLeft => targetCalories - consumedCalories;
  static int get proteinLeft => targetProteinGrams - consumedProteinGrams;
  static int get fatsLeft => targetFatsGrams - consumedFatsGrams;
  static int get carbsLeft => targetCarbsGrams - consumedCarbsGrams;

  static double get calorieProgress => consumedCalories / targetCalories;
  static double get proteinProgress =>
      consumedProteinGrams / targetProteinGrams;
  static double get fatsProgress => consumedFatsGrams / targetFatsGrams;
  static double get carbsProgress => consumedCarbsGrams / targetCarbsGrams;
}
