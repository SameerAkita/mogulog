import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              ),
              Expanded(
                flex: 2,
                child: Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Text('O'), Text('Protein left')],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Text('O'), Text('Fats left')],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Text('O'), Text('Carbs left')],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Column(
                  children: [
                    Text('Recently Uploaded'),
                    Container(color: Colors.teal, height: 100),
                    Container(color: Colors.red, height: 100),
                    Container(color: Colors.blue, height: 100), // need to make scrollable
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
