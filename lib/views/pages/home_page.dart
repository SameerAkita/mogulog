import 'package:flutter/material.dart';
import 'package:mogulog/theme/app_colors.dart';
import 'package:mogulog/widgets/macro_widget.dart';

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
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'mogulog',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                      ),
                    ),
                    Icon(Icons.notifications_none_rounded, size: 40),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '1250',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 40,
                              ),
                            ),
                            Text(
                              'calories left',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 100.0,
                          width: 100.0,
                          child: CircularProgressIndicator(
                            value: 0.8,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.black,
                            ),
                            backgroundColor: AppColors.lightgrey,
                            strokeWidth: 12,
                            strokeCap: StrokeCap.round,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: MacroWidget(
                        amount: '50g',
                        title: 'Protein',
                        value: 0.8,
                        color: AppColors.protein,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: MacroWidget(
                        amount: '30g',
                        title: 'Fats',
                        value: 0.7,
                        color: AppColors.fats,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: MacroWidget(
                        amount: '50g',
                        title: 'Carbs',
                        value: 0.6,
                        color: AppColors.carbs,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Recently Uploaded',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(color: Colors.teal, height: 100),
                            Container(color: Colors.red, height: 100),
                            Container(color: Colors.blue, height: 100),
                            Container(color: Colors.black, height: 100),
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
