import 'package:flutter/material.dart';
import 'package:mogulog/theme/app_colors.dart';
import 'package:mogulog/widgets/analytics/time_range_button.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({super.key});

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

enum TimeRange { week, oneMonth, sixMonths, allTime }

TimeRange selectedRange = TimeRange.week;

class _AnalyticsPageState extends State<AnalyticsPage> {
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                flex: 1,
                                child: TimeRangeButton(
                                  label: '1 Week',
                                  selected: selectedRange == TimeRange.week,
                                  onTap: () {
                                    setState(() {
                                      selectedRange = TimeRange.week;
                                    });
                                  },
                                ),
                              ),
                              SizedBox(width: 4),
                              Expanded(
                                flex: 1,
                                child: TimeRangeButton(
                                  label: '1 Month',
                                  selected: selectedRange == TimeRange.oneMonth,
                                  onTap: () {
                                    setState(() {
                                      selectedRange = TimeRange.oneMonth;
                                    });
                                  },
                                ),
                              ),

                              SizedBox(width: 4),
                              Expanded(
                                flex: 1,
                                child: TimeRangeButton(
                                  label: 'All time',
                                  selected: selectedRange == TimeRange.allTime,
                                  onTap: () {
                                    setState(() {
                                      selectedRange = TimeRange.allTime;
                                    });
                                  },
                                ),
                              ),
                            ],
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
