import 'package:flutter/material.dart';
import 'package:mogulog/data/notifiers.dart';
import 'package:mogulog/views/pages/analytics_page.dart';
import 'package:mogulog/views/pages/home_page.dart';
import 'package:mogulog/views/pages/settings_page.dart';
import 'package:mogulog/views/pages/upload_page.dart';
import 'package:mogulog/widgets/navbar_widget.dart';

List<Widget> pages = [
  HomePage(),
  AnalyticsPage(),
  SettingsPage(),
  UploadPage(),
];

class WidgetTree extends StatelessWidget {
  const WidgetTree({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedPageNotifier,
      builder: (context, selectedPage, child) {
        final isUploadPage = selectedPage == 3;

        return Scaffold(
          body: pages.elementAt(selectedPage),
          bottomNavigationBar: isUploadPage ? null : const NavbarWidget(),
        );
      },
    );
  }
}
