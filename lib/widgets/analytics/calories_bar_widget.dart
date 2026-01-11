import 'package:flutter/material.dart';
import 'package:mogulog/theme/app_colors.dart';

class CaloriesBarWidget extends StatelessWidget {
  const CaloriesBarWidget({super.key});
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
                    child: Column(
                      children: [
                        Expanded(flex: 6, child: Container()),
                        Expanded(
                          flex: 4,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(3),
                              ),
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
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
                    child: Column(
                      children: [
                        Expanded(flex: 1, child: Container()),
                        Expanded(
                          flex: 9,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(3),
                                bottom: Radius.circular(radiusSize),
                              ),
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Text('M', style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
