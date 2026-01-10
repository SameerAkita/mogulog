import 'package:flutter/material.dart';
import 'package:mogulog/theme/app_colors.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({super.key});

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: FractionallySizedBox(
          widthFactor: 0.9,
          child: Column(
            children: [
              Expanded(child: Container()),
              Expanded(child: Container()),
              Expanded(child: Container()),
            ],
          ),
        ),
      ),
    );
  }
}
