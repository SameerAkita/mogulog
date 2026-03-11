import 'package:flutter/material.dart';
import 'package:mogulog/data/notifiers.dart';
import 'package:mogulog/theme/app_colors.dart';

class NavbarWidget extends StatelessWidget {
  const NavbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedPageNotifier,
      builder: (context, selectedPage, child) {
        return NavigationBarTheme(
          data: NavigationBarThemeData(
            backgroundColor: Colors.white,
            indicatorColor: AppColors.orange,
            overlayColor: WidgetStateProperty.all(Colors.transparent),
            iconTheme: WidgetStateProperty.resolveWith<IconThemeData>((states) {
              if (states.contains(WidgetState.selected)) {
                return const IconThemeData(color: AppColors.offwhite);
              }

              return const IconThemeData(color: AppColors.darkbrown);
            }),
            labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((
              states,
            ) {
              if (states.contains(WidgetState.selected)) {
                return const TextStyle(color: AppColors.orange);
              }

              return const TextStyle(color: AppColors.darkbrown);
            }),
          ),
          child: NavigationBar(
            destinations: [
              NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
              NavigationDestination(
                icon: Icon(Icons.analytics),
                label: 'Analytics',
              ),
              NavigationDestination(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
              NavigationDestination(icon: Icon(Icons.add), label: ''),
            ],
            onDestinationSelected: (int value) {
              selectedPageNotifier.value = value;
            },
            selectedIndex: selectedPage,
          ),
        );
      },
    );
  }
}
