import 'package:flutter/material.dart';
import 'package:mogulog/theme/app_colors.dart';

class CaloriesGraphBarWidget extends StatelessWidget {
  final String day;

  const CaloriesGraphBarWidget({super.key, required this.day});
  final double radiusSize = 7;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(radiusSize),
                      ),
                      border: Border(
                        bottom: BorderSide(width: 2, color: Colors.white),
                      ),
                      color: AppColors.lightgrey,
                    ),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: FractionallySizedBox(
                        heightFactor: 0.5,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(3),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(radiusSize),
                      ),
                      color: AppColors.lightgrey,
                    ),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: FractionallySizedBox(
                        heightFactor: 0.7,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(3),
                              bottom: Radius.circular(radiusSize),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Text(day, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
