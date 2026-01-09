import 'package:flutter/material.dart';
import 'package:mogulog/theme/app_colors.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({super.key});

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  Color color = Colors.blue;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: FractionallySizedBox(
          widthFactor: 0.9,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.tempgrey,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 2),

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                InkWell(
                                  child: Container(
                                    color: color,
                                    child: Text(
                                      '1 Week',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      color = Colors.red;
                                    });
                                  },
                                ),
                                Text('1 Month', style: TextStyle(fontSize: 18)),
                                Text(
                                  '6 Months',
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  'All time',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 8),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.tempgrey,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
