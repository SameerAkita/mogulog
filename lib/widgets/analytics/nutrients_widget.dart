import 'package:flutter/material.dart';

class NutrientsWidget extends StatelessWidget {
  const NutrientsWidget({super.key});

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
                'Nutrients',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Expanded(child: Container(color: Colors.blue)),
            ],
          ),
        ),
      ),
    );
  }
}
