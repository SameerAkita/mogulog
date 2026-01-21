import 'package:flutter/material.dart';
import 'package:mogulog/widgets/settings/settings_widget.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: FractionallySizedBox(
          widthFactor: 0.9,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Settings',
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
              SettingsWidget(title: 'Account'),
              SettingsWidget(title: 'Goals'),
              SettingsWidget(title: 'Support'),
            ],
          ),
        ),
      ),
    );
  }
}
