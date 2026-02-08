import 'package:flutter/material.dart';
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '2250',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 48,
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
              SizedBox(height: 8),
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
