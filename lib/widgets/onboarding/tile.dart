import 'package:flutter/material.dart';

class Tile extends StatelessWidget {
  final int value;
  final String unit;

  const Tile({super.key, required this.value, required this.unit});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('$value $unit', style: TextStyle(fontSize: 16)));
  }
}
