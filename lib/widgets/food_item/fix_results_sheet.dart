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
          Expanded(child: Container()),

          SizedBox(
            width: 200,
            child: ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.black),
                foregroundColor: WidgetStateProperty.all(Colors.white),
                textStyle: WidgetStateProperty.all(
                  TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                padding: WidgetStateProperty.all(
                  EdgeInsets.symmetric(vertical: 14),
                ),
                overlayColor: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.pressed)) {
                    return Colors.white.withAlpha(100);
                  }
                  return null;
                }),
                splashFactory: NoSplash.splashFactory,
              ),
              child: Text('Update'),
            ),
          ),
        ],
      ),
    );
  }
}
