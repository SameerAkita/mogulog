import 'package:flutter/material.dart';
import 'package:mogulog/theme/app_colors.dart';

class RecentUploadWidget extends StatelessWidget {
  const RecentUploadWidget({super.key});

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
              child: Image.asset(
                'assets/images/oyakodon.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text('data'),
        ],
      ),
    );
  }
}
