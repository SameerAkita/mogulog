import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: FractionallySizedBox(
            widthFactor: 0.9,
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'mogulog',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                        ),
                      ),
                      Icon(Icons.notifications_none_rounded, size: 40),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '1250',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 40,
                              ),
                            ),
                            Text(
                              'calories left',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        Text(
                          'O',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 100,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(flex: 2, child: Container(color: Colors.green)),
                Expanded(flex: 4, child: Container(color: Colors.yellow)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
