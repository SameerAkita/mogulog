import 'package:flutter/material.dart';
import 'package:mogulog/theme/app_colors.dart';

class RecentUploadWidget extends StatelessWidget {
  final String title;
  final String image;
  final int calories;
  final double protein;
  final double fats;
  final double carbs;
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
        color: AppColors.lightgrey,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Icon(Icons.local_fire_department),
                      Text('$calories calories'),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Protein'),
                      Icon(Icons.water_drop),
                      Text('fats'),
                      Text('carbs'),
                    ],
                  ),
                ],
              ),
              Text('time'),
            ],
          ),
        ],
      ),
    );
  }
}
