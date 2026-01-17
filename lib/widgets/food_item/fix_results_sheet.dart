import 'package:flutter/material.dart';

class FixResultsSheet extends StatelessWidget {
  const FixResultsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Fix results',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 8),
          TextField(
            decoration: const InputDecoration(
              hintText: 'e.g. This was chicken thigh, not breast...',
              border: OutlineInputBorder(),
            ),
          ),
          
          ElevatedButton(onPressed: () {}, child: Text('button')),
        ],
      ),
    );
  }
}
