import 'package:flutter/material.dart';
import 'package:mogulog/theme/app_colors.dart';
import 'package:mogulog/widgets/onboarding/tile.dart';

class OnboardingListwheel extends StatelessWidget {
  final int min;
  final int itemCount;
  final int selectedIndex;
  final String unit;
  final ValueChanged<int> onChanged;

  const OnboardingListwheel({
    super.key,
    required this.min,
    required this.itemCount,
    required this.selectedIndex,
    required this.unit,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: Stack(
        alignment: Alignment.center,
        children: [
          FractionallySizedBox(
            widthFactor: 0.9,
            child: Container(
              height: 25,
              decoration: BoxDecoration(
                color: AppColors.lightgrey,
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
          ClipRRect(
            child: ListWheelScrollView.useDelegate(
              onSelectedItemChanged: onChanged,

              itemExtent: 25,
              perspective: 0.005,
              diameterRatio: 1.2,
              physics: FixedExtentScrollPhysics(),
              childDelegate: ListWheelChildBuilderDelegate(
                childCount: 181,
                builder: (context, index) {
                  return Tile(
                    value: index + min,
                    unit: unit,
                    isSelected: index == selectedIndex,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
