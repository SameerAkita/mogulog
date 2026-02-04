import 'package:flutter/material.dart';

class Tile extends StatelessWidget {
  final int value;
  final String unit;
  final bool isSelected;

  const Tile({
    super.key,
    required this.value,
    required this.unit,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedDefaultTextStyle(
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeInOut,
        style: TextStyle(
          fontSize: isSelected ? 18 : 16,
          color: isSelected ? Colors.black : Colors.grey,
        ),
        child: Text('$value $unit'),
      ),
    );
  }
}
