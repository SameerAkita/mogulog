import 'package:flutter/material.dart';
import 'package:mogulog/theme/app_colors.dart';

class MacroWidget extends StatelessWidget {
  final String amount;
  final String title;
  final double value;
  final Color color;

  const MacroWidget({
    super.key,
    required this.amount,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              amount,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
              textHeightBehavior: const TextHeightBehavior(
                applyHeightToFirstAscent: false,
                applyHeightToLastDescent: false,
              ),
            ),
            Text('$title left'),
            SizedBox(height: 8),
            Center(
              child: SizedBox(
                height: 60,
                width: 60,
                child: CircularProgressIndicator(
                  value: value,
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                  backgroundColor: AppColors.lightgrey,
                  strokeWidth: 7,
                  strokeCap: StrokeCap.round,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
