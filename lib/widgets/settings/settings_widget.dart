import 'package:flutter/material.dart';

class SettingsWidget extends StatelessWidget {
  final String title;

  const SettingsWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      
      child: Padding(
        padding: EdgeInsetsGeometry.symmetric(vertical: 4, horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(title), Icon(Icons.arrow_forward_ios)],
        ),
      ),
    );
  }
}
