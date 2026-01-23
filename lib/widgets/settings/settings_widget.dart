import 'package:flutter/material.dart';

class SettingsWidget extends StatelessWidget {
  final String title;

  const SettingsWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(15),

        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(vertical: 12, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: TextStyle(fontSize: 16)),
              Icon(Icons.arrow_forward_ios, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}
