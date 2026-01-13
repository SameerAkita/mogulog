import 'package:flutter/material.dart';
import 'package:mogulog/theme/app_colors.dart';

class FoodItemPage extends StatelessWidget {
  const FoodItemPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Meal'),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Expanded(flex: 7, child: Container(color: AppColors.lightgrey)),
          Expanded(flex: 10, child: Container(color: Colors.red)),
        ],
      ),
    );
  }
}
