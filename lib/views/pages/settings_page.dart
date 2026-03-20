import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:mogulog/data/daily_nutrition_data.dart';
import 'package:mogulog/theme/app_colors.dart';
import 'package:mogulog/widgets/settings/settings_widget.dart';

enum BiologicalSex { male, female }

enum ActivityLevelOption { sedentary, light, moderate, active, veryActive }

enum WeightGoalMode { lose, maintain, gain }

extension BiologicalSexLabel on BiologicalSex {
  String get label => this == BiologicalSex.male ? 'Male' : 'Female';
}

extension ActivityLevelOptionData on ActivityLevelOption {
  String get label {
    switch (this) {
      case ActivityLevelOption.sedentary:
        return 'Sedentary';
      case ActivityLevelOption.light:
        return 'Light';
      case ActivityLevelOption.moderate:
        return 'Moderate';
      case ActivityLevelOption.active:
        return 'Active';
      case ActivityLevelOption.veryActive:
        return 'Very Active';
    }
  }

  double get multiplier {
    switch (this) {
      case ActivityLevelOption.sedentary:
        return 1.2;
      case ActivityLevelOption.light:
        return 1.375;
      case ActivityLevelOption.moderate:
        return 1.55;
      case ActivityLevelOption.active:
        return 1.725;
      case ActivityLevelOption.veryActive:
        return 1.9;
    }
  }
}

extension WeightGoalModeLabel on WeightGoalMode {
  String get label {
    switch (this) {
      case WeightGoalMode.lose:
        return 'Lose';
      case WeightGoalMode.maintain:
        return 'Maintain';
      case WeightGoalMode.gain:
        return 'Gain';
    }
  }
}

class MacroTargets {
  final double proteinPercent;
  final double fatsPercent;
  final double carbsPercent;

  const MacroTargets({
    required this.proteinPercent,
    required this.fatsPercent,
    required this.carbsPercent,
  });
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int age = 28;
  int heightCm = 170;
  double weightKg = 72;
  BiologicalSex sex = BiologicalSex.male;
  ActivityLevelOption activityLevel = ActivityLevelOption.moderate;

  WeightGoalMode goalMode = WeightGoalMode.lose;
  double weeklyRateKg = 0.5;
  bool mealRemindersEnabled = true;

  bool useAutomaticCalories = true;
  bool useAutomaticMacros = true;
  int manualCalories = 2100;
  double manualProteinPercent = 30;
  double manualFatsPercent = 25;

  bool analyticsOptIn = false;

  double get bmr {
    final base = (10 * weightKg) + (6.25 * heightCm) - (5 * age);
    return sex == BiologicalSex.male ? base + 5 : base - 161;
  }

  double get maintenanceCalories => bmr * activityLevel.multiplier;

  double get dailyGoalAdjustment {
    switch (goalMode) {
      case WeightGoalMode.lose:
        return -(weeklyRateKg * 1100);
      case WeightGoalMode.maintain:
        return 0;
      case WeightGoalMode.gain:
        return weeklyRateKg * 1100;
    }
  }

  int get recommendedCalories {
    final target = maintenanceCalories + dailyGoalAdjustment;
    return target.clamp(1200, 4200).round();
  }

  MacroTargets get recommendedMacros {
    final targetCalories = recommendedCalories.toDouble();
    final proteinMultiplier = switch (goalMode) {
      WeightGoalMode.lose => 1.8,
      WeightGoalMode.maintain => 1.6,
      WeightGoalMode.gain => 1.7,
    };
    final fatsMultiplier = switch (goalMode) {
      WeightGoalMode.lose => 0.8,
      WeightGoalMode.maintain => 0.75,
      WeightGoalMode.gain => 0.7,
    };

    final proteinCalories = weightKg * proteinMultiplier * 4;
    final fatCalories = math.max(
      weightKg * fatsMultiplier * 9,
      targetCalories * 0.22,
    );
    final carbsCalories = math.max(
      targetCalories - proteinCalories - fatCalories,
      targetCalories * 0.15,
    );
    final totalCalories = proteinCalories + fatCalories + carbsCalories;

    return MacroTargets(
      proteinPercent: (proteinCalories / totalCalories) * 100,
      fatsPercent: (fatCalories / totalCalories) * 100,
      carbsPercent: (carbsCalories / totalCalories) * 100,
    );
  }

  int get effectiveCalories =>
      useAutomaticCalories ? recommendedCalories : manualCalories;

  MacroTargets get effectiveMacros {
    if (useAutomaticMacros) {
      return recommendedMacros;
    }

    return MacroTargets(
      proteinPercent: manualProteinPercent,
      fatsPercent: manualFatsPercent,
      carbsPercent: 100 - manualProteinPercent - manualFatsPercent,
    );
  }

  String get profileSummary =>
      '$age y • ${sex.label} • $heightCm cm • ${weightKg.toStringAsFixed(1)} kg • ${activityLevel.label}';

  String get goalSummary {
    if (goalMode == WeightGoalMode.maintain) {
      return 'Maintain current weight';
    }

    return '${goalMode.label} ${weeklyRateKg.toStringAsFixed(2)} kg/week';
  }

  String get nutritionSummary =>
      '${DailyNutritionData.targetCalories} kcal • ${DailyNutritionData.targetProteinGrams}P / ${DailyNutritionData.targetFatsGrams}F / ${DailyNutritionData.targetCarbsGrams}C';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: FractionallySizedBox(
          widthFactor: 0.92,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 8),
                child: Text(
                  'Settings',
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView(
                  children: [
                    _SectionCard(
                      child: Column(
                        children: [
                          SettingsWidget(
                            title: 'Profile',
                            subtitle: profileSummary,
                            leadingIcon: Icons.person_outline_rounded,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProfileSettingsPage(
                                    age: age,
                                    heightCm: heightCm,
                                    weightKg: weightKg,
                                    sex: sex,
                                    activityLevel: activityLevel,
                                    onAgeChanged: (value) =>
                                        setState(() => age = value),
                                    onHeightChanged: (value) =>
                                        setState(() => heightCm = value),
                                    onWeightChanged: (value) =>
                                        setState(() => weightKg = value),
                                    onSexChanged: (value) =>
                                        setState(() => sex = value),
                                    onActivityChanged: (value) =>
                                        setState(() => activityLevel = value),
                                  ),
                                ),
                              );
                            },
                          ),
                          const Divider(height: 1),
                          SettingsWidget(
                            title: 'Goal',
                            subtitle: goalSummary,
                            leadingIcon: Icons.flag_outlined,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => GoalSettingsPage(
                                    goalMode: goalMode,
                                    weeklyRateKg: weeklyRateKg,
                                    mealRemindersEnabled: mealRemindersEnabled,
                                    onGoalModeChanged: (value) =>
                                        setState(() => goalMode = value),
                                    onWeeklyRateChanged: (value) =>
                                        setState(() => weeklyRateKg = value),
                                    onMealRemindersChanged: (value) => setState(
                                      () => mealRemindersEnabled = value,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          const Divider(height: 1),
                          SettingsWidget(
                            title: 'Nutrition Targets',
                            subtitle: nutritionSummary,
                            leadingIcon: Icons.restaurant_menu_outlined,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const NutritionTargetsPage(),
                                ),
                              );
                            },
                          ),
                          const Divider(height: 1),
                          SettingsWidget(
                            title: 'Privacy & Permissions',
                            subtitle:
                                'Camera access, privacy policy, terms, and local data controls',
                            leadingIcon: Icons.privacy_tip_outlined,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PrivacySettingsPage(
                                    analyticsOptIn: analyticsOptIn,
                                    onAnalyticsOptInChanged: (value) =>
                                        setState(() => analyticsOptIn = value),
                                  ),
                                ),
                              );
                            },
                          ),
                          const Divider(height: 1),
                          SettingsWidget(
                            title: 'Support',
                            subtitle:
                                'Support contact and App Store review checklist',
                            leadingIcon: Icons.help_outline_rounded,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const SupportSettingsPage(),
                                ),
                              );
                            },
                          ),
                          const Divider(height: 1),
                          SettingsWidget(
                            title: 'About',
                            subtitle: 'Version, build status, and app info',
                            leadingIcon: Icons.info_outline_rounded,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const AboutSettingsPage(),
                                ),
                              );
                            },
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

class ProfileSettingsPage extends StatefulWidget {
  final int age;
  final int heightCm;
  final double weightKg;
  final BiologicalSex sex;
  final ActivityLevelOption activityLevel;
  final ValueChanged<int> onAgeChanged;
  final ValueChanged<int> onHeightChanged;
  final ValueChanged<double> onWeightChanged;
  final ValueChanged<BiologicalSex> onSexChanged;
  final ValueChanged<ActivityLevelOption> onActivityChanged;

  const ProfileSettingsPage({
    super.key,
    required this.age,
    required this.heightCm,
    required this.weightKg,
    required this.sex,
    required this.activityLevel,
    required this.onAgeChanged,
    required this.onHeightChanged,
    required this.onWeightChanged,
    required this.onSexChanged,
    required this.onActivityChanged,
  });

  @override
  State<ProfileSettingsPage> createState() => _ProfileSettingsPageState();
}

class _ProfileSettingsPageState extends State<ProfileSettingsPage> {
  late int age = widget.age;
  late int heightCm = widget.heightCm;
  late double weightKg = widget.weightKg;
  late BiologicalSex sex = widget.sex;
  late ActivityLevelOption activityLevel = widget.activityLevel;

  @override
  Widget build(BuildContext context) {
    return _SettingsScaffold(
      title: 'Profile',
      child: ListView(
        children: [
          _SectionCard(
            title: 'Body Data',
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  SegmentedButton<BiologicalSex>(
                    showSelectedIcon: false,
                    segments: const [
                      ButtonSegment(
                        value: BiologicalSex.male,
                        label: Text('Male'),
                      ),
                      ButtonSegment(
                        value: BiologicalSex.female,
                        label: Text('Female'),
                      ),
                    ],
                    selected: {sex},
                    onSelectionChanged: (value) {
                      setState(() => sex = value.first);
                      widget.onSexChanged(value.first);
                    },
                  ),
                  const SizedBox(height: 18),
                  _SliderSetting(
                    label: 'Age',
                    valueLabel: '$age years',
                    minLabel: '18',
                    maxLabel: '80',
                    value: age.toDouble(),
                    min: 18,
                    max: 80,
                    divisions: 62,
                    color: AppColors.orange,
                    onChanged: (value) {
                      setState(() => age = value.round());
                      widget.onAgeChanged(value.round());
                    },
                  ),
                  const SizedBox(height: 14),
                  _SliderSetting(
                    label: 'Height',
                    valueLabel: '$heightCm cm',
                    minLabel: '140',
                    maxLabel: '210',
                    value: heightCm.toDouble(),
                    min: 140,
                    max: 210,
                    divisions: 70,
                    color: AppColors.orange,
                    onChanged: (value) {
                      setState(() => heightCm = value.round());
                      widget.onHeightChanged(value.round());
                    },
                  ),
                  const SizedBox(height: 14),
                  _SliderSetting(
                    label: 'Weight',
                    valueLabel: '${weightKg.toStringAsFixed(1)} kg',
                    minLabel: '40',
                    maxLabel: '150',
                    value: weightKg,
                    min: 40,
                    max: 150,
                    divisions: 220,
                    color: AppColors.orange,
                    onChanged: (value) {
                      setState(
                        () => weightKg = double.parse(value.toStringAsFixed(1)),
                      );
                      widget.onWeightChanged(
                        double.parse(value.toStringAsFixed(1)),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          _SectionCard(
            title: 'Activity Level',
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: DropdownButtonFormField<ActivityLevelOption>(
                initialValue: activityLevel,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Choose your typical activity',
                ),
                items: ActivityLevelOption.values
                    .map(
                      (level) => DropdownMenuItem(
                        value: level,
                        child: Text(level.label),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }

                  setState(() => activityLevel = value);
                  widget.onActivityChanged(value);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GoalSettingsPage extends StatefulWidget {
  final WeightGoalMode goalMode;
  final double weeklyRateKg;
  final bool mealRemindersEnabled;
  final ValueChanged<WeightGoalMode> onGoalModeChanged;
  final ValueChanged<double> onWeeklyRateChanged;
  final ValueChanged<bool> onMealRemindersChanged;

  const GoalSettingsPage({
    super.key,
    required this.goalMode,
    required this.weeklyRateKg,
    required this.mealRemindersEnabled,
    required this.onGoalModeChanged,
    required this.onWeeklyRateChanged,
    required this.onMealRemindersChanged,
  });

  @override
  State<GoalSettingsPage> createState() => _GoalSettingsPageState();
}

class _GoalSettingsPageState extends State<GoalSettingsPage> {
  late WeightGoalMode goalMode = widget.goalMode;
  late double weeklyRateKg = widget.weeklyRateKg;
  late bool mealRemindersEnabled = widget.mealRemindersEnabled;

  @override
  Widget build(BuildContext context) {
    return _SettingsScaffold(
      title: 'Goal',
      child: ListView(
        children: [
          _SectionCard(
            title: 'Weight Goal',
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  SegmentedButton<WeightGoalMode>(
                    showSelectedIcon: false,
                    segments: const [
                      ButtonSegment(
                        value: WeightGoalMode.lose,
                        label: Text('Lose'),
                      ),
                      ButtonSegment(
                        value: WeightGoalMode.maintain,
                        label: Text('Maintain'),
                      ),
                      ButtonSegment(
                        value: WeightGoalMode.gain,
                        label: Text('Gain'),
                      ),
                    ],
                    selected: {goalMode},
                    onSelectionChanged: (value) {
                      setState(() => goalMode = value.first);
                      widget.onGoalModeChanged(value.first);
                    },
                  ),
                  if (goalMode != WeightGoalMode.maintain) ...[
                    const SizedBox(height: 18),
                    _SliderSetting(
                      label: 'Weekly rate',
                      valueLabel: '${weeklyRateKg.toStringAsFixed(2)} kg/week',
                      minLabel: '0.10',
                      maxLabel: '1.00',
                      value: weeklyRateKg,
                      min: 0.1,
                      max: 1.0,
                      divisions: 18,
                      color: AppColors.orange,
                      onChanged: (value) {
                        setState(() => weeklyRateKg = value);
                        widget.onWeeklyRateChanged(value);
                      },
                    ),
                  ] else ...[
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppColors.orangeAccent,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Text(
                        'Maintenance mode keeps your calorie target close to estimated maintenance.',
                        style: TextStyle(
                          color: AppColors.darkbrown,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          _SectionCard(
            title: 'Preferences',
            child: SwitchListTile(
              value: mealRemindersEnabled,
              activeThumbColor: AppColors.orange,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              secondary: const Icon(
                Icons.notifications_active_outlined,
                color: AppColors.darkbrown,
              ),
              title: const Text('Meal reminders'),
              subtitle: const Text('Morning, lunch, and dinner nudges'),
              onChanged: (value) {
                setState(() => mealRemindersEnabled = value);
                widget.onMealRemindersChanged(value);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class NutritionTargetsPage extends StatelessWidget {
  const NutritionTargetsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _SettingsScaffold(
      title: 'Nutrition Targets',
      child: ListView(
        children: [
          _SectionCard(
            title: 'Daily Targets',
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${DailyNutritionData.targetCalories} kcal/day',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${DailyNutritionData.targetProteinGrams}g protein • ${DailyNutritionData.targetFatsGrams}g fats • ${DailyNutritionData.targetCarbsGrams}g carbs',
                    style: const TextStyle(color: Colors.black54),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          _SectionCard(
            title: 'Consumed Today',
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${DailyNutritionData.consumedCalories} kcal',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _PfcSummaryTile(
                    label: 'Protein',
                    color: AppColors.protein,
                    grams: DailyNutritionData.consumedProteinGrams,
                  ),
                  const SizedBox(height: 8),
                  _PfcSummaryTile(
                    label: 'Fats',
                    color: AppColors.fats,
                    grams: DailyNutritionData.consumedFatsGrams,
                  ),
                  const SizedBox(height: 8),
                  _PfcSummaryTile(
                    label: 'Carbs',
                    color: AppColors.carbs,
                    grams: DailyNutritionData.consumedCarbsGrams,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          _SectionCard(
            title: 'Remaining Today',
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${DailyNutritionData.caloriesLeft} kcal left',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _PfcSummaryTile(
                    label: 'Protein',
                    color: AppColors.protein,
                    grams: DailyNutritionData.proteinLeft,
                  ),
                  const SizedBox(height: 8),
                  _PfcSummaryTile(
                    label: 'Fats',
                    color: AppColors.fats,
                    grams: DailyNutritionData.fatsLeft,
                  ),
                  const SizedBox(height: 8),
                  _PfcSummaryTile(
                    label: 'Carbs',
                    color: AppColors.carbs,
                    grams: DailyNutritionData.carbsLeft,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PrivacySettingsPage extends StatefulWidget {
  final bool analyticsOptIn;
  final ValueChanged<bool> onAnalyticsOptInChanged;

  const PrivacySettingsPage({
    super.key,
    required this.analyticsOptIn,
    required this.onAnalyticsOptInChanged,
  });

  @override
  State<PrivacySettingsPage> createState() => _PrivacySettingsPageState();
}

class _PrivacySettingsPageState extends State<PrivacySettingsPage> {
  late bool analyticsOptIn = widget.analyticsOptIn;

  void showInfoSheet({
    required String title,
    required String description,
    List<Widget> extraChildren = const [],
  }) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      backgroundColor: Colors.white,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  description,
                  style: const TextStyle(height: 1.45, color: Colors.black87),
                ),
                if (extraChildren.isNotEmpty) const SizedBox(height: 16),
                ...extraChildren,
              ],
            ),
          ),
        );
      },
    );
  }

  void confirmDeleteLocalData() {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete local data?'),
          content: const Text(
            'This clears local demo logs and cached app data from this device. '
            'It does not affect any server-side account because the app does not use sign-in yet.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Local data cleared.')),
                );
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _SettingsScaffold(
      title: 'Privacy & Permissions',
      child: ListView(
        children: [
          _SectionCard(
            child: Column(
              children: [
                SettingsWidget(
                  title: 'Camera access',
                  subtitle:
                      'Required to capture meal photos from the upload screen',
                  leadingIcon: Icons.camera_alt_outlined,
                  onTap: () {
                    showInfoSheet(
                      title: 'Camera access',
                      description:
                          'Mogulog uses camera access only when you open the upload screen and capture a meal photo. '
                          'If permission is denied, photo capture will not work until camera access is enabled again in iOS Settings.',
                    );
                  },
                ),
                const Divider(height: 1),
                SwitchListTile(
                  value: analyticsOptIn,
                  activeThumbColor: AppColors.orange,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  secondary: const Icon(
                    Icons.bar_chart_outlined,
                    color: AppColors.darkbrown,
                  ),
                  title: const Text('Share anonymous analytics'),
                  subtitle: const Text(
                    'Disabled by default for review-friendly privacy',
                  ),
                  onChanged: (value) {
                    setState(() => analyticsOptIn = value);
                    widget.onAnalyticsOptInChanged(value);
                  },
                ),
                const Divider(height: 1),
                SettingsWidget(
                  title: 'Privacy policy',
                  subtitle:
                      'In-app copy. Replace with your final hosted policy before release.',
                  leadingIcon: Icons.privacy_tip_outlined,
                  onTap: () {
                    showInfoSheet(
                      title: 'Privacy Policy',
                      description:
                          'Mogulog stores meal photos, nutrition logs, user profile inputs, and settings needed to calculate nutrition targets and support the app experience. '
                          'Camera permission is requested only when capturing a meal. '
                          'If you later add cloud sync, accounts, analytics, or third-party services, this policy must be updated to describe what data is collected, why it is used, how long it is retained, and how users can request deletion.',
                      extraChildren: const [
                        _PolicyBullet(
                          text:
                              'Data used today: meal photos you capture, nutrition logs you create, profile inputs used for calorie calculations, and local app settings.',
                        ),
                        _PolicyBullet(
                          text:
                              'No sign-in flow is present in the current app, so there is no server-side account to delete yet.',
                        ),
                        _PolicyBullet(
                          text:
                              'Before App Store submission, add a public privacy policy URL in App Store Connect as well.',
                        ),
                      ],
                    );
                  },
                ),
                const Divider(height: 1),
                SettingsWidget(
                  title: 'Terms of use',
                  subtitle: 'Basic in-app terms and usage notice',
                  leadingIcon: Icons.description_outlined,
                  onTap: () {
                    showInfoSheet(
                      title: 'Terms of Use',
                      description:
                          'Mogulog is intended for personal meal logging and nutrition tracking. '
                          'Nutrition values shown by the app are informational only and should not be treated as medical advice. '
                          'You are responsible for reviewing logged content before relying on it.',
                    );
                  },
                ),
                const Divider(height: 1),
                SettingsWidget(
                  title: 'Delete local data',
                  subtitle:
                      'Clear photos, logs, profile data, and preferences stored on this device',
                  leadingIcon: Icons.delete_outline_rounded,
                  iconColor: Colors.red,
                  titleColor: Colors.red,
                  onTap: confirmDeleteLocalData,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SupportSettingsPage extends StatelessWidget {
  const SupportSettingsPage({super.key});

  void showInfoSheet(
    BuildContext context, {
    required String title,
    required String description,
    List<Widget> extraChildren = const [],
  }) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      backgroundColor: Colors.white,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  description,
                  style: const TextStyle(height: 1.45, color: Colors.black87),
                ),
                if (extraChildren.isNotEmpty) const SizedBox(height: 16),
                ...extraChildren,
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _SettingsScaffold(
      title: 'Support',
      child: ListView(
        children: [
          _SectionCard(
            child: Column(
              children: [
                SettingsWidget(
                  title: 'Contact support',
                  subtitle:
                      'support@mogulog.app\nReplace with your real support channel before review',
                  leadingIcon: Icons.mail_outline_rounded,
                  onTap: () {
                    showInfoSheet(
                      context,
                      title: 'Contact Support',
                      description:
                          'Use a real support email or support URL that App Review can access. '
                          'If the app later requires login or backend access, make sure the reviewer also has working test credentials and any relevant instructions in App Store Connect review notes.',
                    );
                  },
                ),
                const Divider(height: 1),
                SettingsWidget(
                  title: 'Review checklist',
                  subtitle:
                      'Metadata, permissions, privacy URL, and working demo flow',
                  leadingIcon: Icons.fact_check_outlined,
                  onTap: () {
                    showInfoSheet(
                      context,
                      title: 'Pre-submission checklist',
                      description:
                          'Before submitting to the App Store, make sure the app metadata is complete, camera permission usage is accurate, your privacy policy URL is live in App Store Connect, and the app can be fully reviewed without broken flows.',
                      extraChildren: const [
                        _PolicyBullet(
                          text:
                              'Provide a working privacy policy URL in App Store Connect and keep it consistent with the in-app policy.',
                        ),
                        _PolicyBullet(
                          text:
                              'If you add account creation later, Apple requires in-app account deletion as well.',
                        ),
                        _PolicyBullet(
                          text:
                              'If any feature depends on backend access, include review instructions or demo credentials during submission.',
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AboutSettingsPage extends StatelessWidget {
  const AboutSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _SettingsScaffold(
      title: 'About',
      child: ListView(
        children: const [
          _SectionCard(
            child: Column(
              children: [
                SettingsWidget(
                  title: 'App version',
                  subtitle: '1.0.0 (1)',
                  leadingIcon: Icons.info_outline_rounded,
                ),
                Divider(height: 1),
                SettingsWidget(
                  title: 'Build status',
                  subtitle: 'Prototype build for local testing',
                  leadingIcon: Icons.build_circle_outlined,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsScaffold extends StatelessWidget {
  final String title;
  final Widget child;

  const _SettingsScaffold({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.white,
        foregroundColor: AppColors.darkbrown,
        scrolledUnderElevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: child,
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String? title;
  final Widget child;

  const _SectionCard({this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
              child: Text(
                title!,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.darkbrown,
                ),
              ),
            ),
          child,
        ],
      ),
    );
  }
}

class _SliderSetting extends StatelessWidget {
  final String label;
  final String valueLabel;
  final String minLabel;
  final String maxLabel;
  final double value;
  final double min;
  final double max;
  final int divisions;
  final Color color;
  final ValueChanged<double> onChanged;

  const _SliderSetting({
    required this.label,
    required this.valueLabel,
    required this.minLabel,
    required this.maxLabel,
    required this.value,
    required this.min,
    required this.max,
    required this.divisions,
    required this.color,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            Text(
              valueLabel,
              style: const TextStyle(
                color: AppColors.darkbrown,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        Slider(
          value: value,
          min: min,
          max: max,
          divisions: divisions,
          activeColor: color,
          onChanged: onChanged,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(minLabel, style: const TextStyle(color: Colors.black54)),
            Text(maxLabel, style: const TextStyle(color: Colors.black54)),
          ],
        ),
      ],
    );
  }
}

class _PfcSummaryTile extends StatelessWidget {
  final String label;
  final Color color;
  final int grams;

  const _PfcSummaryTile({
    required this.label,
    required this.color,
    required this.grams,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        Text('${grams}g', style: const TextStyle(color: Colors.black54)),
      ],
    );
  }
}

class _PolicyBullet extends StatelessWidget {
  final String text;

  const _PolicyBullet({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.only(top: 7),
            decoration: const BoxDecoration(
              color: AppColors.orange,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(height: 1.4, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
