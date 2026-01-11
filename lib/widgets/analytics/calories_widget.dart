import 'package:flutter/material.dart';
import 'package:mogulog/theme/app_colors.dart';
import 'package:mogulog/widgets/analytics/calories_bar_widget.dart';

class CaloriesWidget extends StatelessWidget {
  const CaloriesWidget({super.key});

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
                'Calories',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Expanded(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 6,
                      ), // padding counteracts the circularprogressindicator's stroke width
                      child: SizedBox(
                        height: 100.0,
                        width: 100.0,
                        child: CircularProgressIndicator(
                          value: 0.8,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.black,
                          ),
                          backgroundColor: AppColors.lightgrey,
                          strokeWidth: 10,
                          strokeCap: StrokeCap.round,
                        ),
                      ),
                    ),
                    SizedBox(width: 18),
                    Expanded(
                      child: Row(
                        children: [
                          CaloriesBarWidget(),
                          SizedBox(width: 8),
                          CaloriesBarWidget(),
                          SizedBox(width: 8),
                          CaloriesBarWidget(),
                          SizedBox(width: 8),
                          CaloriesBarWidget(),
                          SizedBox(width: 8),
                          CaloriesBarWidget(),
                          SizedBox(width: 8),
                          CaloriesBarWidget(),
                          SizedBox(width: 8),
                          CaloriesBarWidget(),
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
