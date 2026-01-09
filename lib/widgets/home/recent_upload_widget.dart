import 'package:flutter/material.dart';
import 'package:mogulog/theme/app_colors.dart';

class RecentUploadWidget extends StatelessWidget {
  final String title;
  final String image;
  final int calories;
  final int protein;
  final int fats;
  final int carbs;
  final String time;

  const RecentUploadWidget({
    super.key,
    required this.title,
    required this.image,
    required this.calories,
    required this.protein,
    required this.fats,
    required this.carbs,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 125,
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppColors.tempgrey,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              bottomLeft: Radius.circular(15),
            ),
            child: Container(
              width: 125,
              height: double.infinity,
              color: Colors.grey,
              child: Image.asset(image, fit: BoxFit.cover),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsetsGeometry.symmetric(horizontal: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(time),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.local_fire_department, size: 20),
                      Text('$calories calories'),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.egg_alt, size: 20, color: AppColors.protein),
                      Text('${protein}g'),
                      Text(' '),
                      Icon(Icons.water_drop, size: 20, color: AppColors.fats),
                      Text('${fats}g'),
                      Text(' '),
                      Icon(Icons.cookie, size: 20, color: AppColors.carbs),
                      Text('${carbs}g'),
                    ],
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
