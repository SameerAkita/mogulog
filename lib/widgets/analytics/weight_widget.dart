import 'package:flutter/material.dart';
import 'package:mogulog/theme/app_colors.dart';

enum WeightRange { sevenDays, thirtyDays, ninetyDays }

class WeightWidget extends StatefulWidget {
  const WeightWidget({super.key});

  @override
  State<WeightWidget> createState() => _WeightWidgetState();
}

class _WeightWidgetState extends State<WeightWidget> {
  WeightRange selectedRange = WeightRange.sevenDays;

  late final Map<WeightRange, List<double>> weightLogs = {
    WeightRange.sevenDays: [71.6, 71.4, 71.2, 71.3, 71.0, 70.9, 70.7],
    WeightRange.thirtyDays: [
      72.8,
      72.6,
      72.5,
      72.4,
      72.6,
      72.3,
      72.2,
      72.1,
      72.0,
      71.9,
      72.0,
      71.8,
      71.7,
      71.9,
      71.6,
      71.5,
      71.4,
      71.3,
      71.4,
      71.2,
      71.1,
      71.0,
      71.1,
      71.0,
      70.9,
      70.8,
      70.9,
      70.8,
      70.7,
      70.7,
    ],
    WeightRange.ninetyDays: List<double>.generate(
      90,
      (index) => 75.5 - (index * 0.05) + ((index % 6) * 0.04),
    ),
  };

  List<double> get currentLogs => weightLogs[selectedRange]!;

  String get selectedLabel {
    switch (selectedRange) {
      case WeightRange.sevenDays:
        return '7D';
      case WeightRange.thirtyDays:
        return '30D';
      case WeightRange.ninetyDays:
        return '90D';
    }
  }

  List<String> get xAxisLabels {
    switch (selectedRange) {
      case WeightRange.sevenDays:
        return const ['Thu', 'Fri', 'Sat', 'Sun', 'Mon', 'Tue', 'Wed'];
      case WeightRange.thirtyDays:
        return const ['30d', '23d', '16d', '9d', 'Today'];
      case WeightRange.ninetyDays:
        return const ['90d', '67d', '45d', '22d', 'Today'];
    }
  }

  double get latestWeight => currentLogs.last;

  double get changeInRange => currentLogs.last - currentLogs.first;

  Future<void> addWeightLog() async {
    final value = await showDialog<double>(
      context: context,
      builder: (context) {
        return const _AddWeightLogDialog();
      },
    );

    if (value == null) {
      return;
    }

    setState(() {
      for (final entry in weightLogs.entries) {
        entry.value.add(value);
        final maxLength = switch (entry.key) {
          WeightRange.sevenDays => 7,
          WeightRange.thirtyDays => 30,
          WeightRange.ninetyDays => 90,
        };

        if (entry.value.length > maxLength) {
          entry.value.removeAt(0);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final changeIsDown = changeInRange <= 0;

    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Color(0x12000000),
              blurRadius: 18,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Weight',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              '${latestWeight.toStringAsFixed(1)} kg',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: changeIsDown
                                    ? Color.lerp(
                                        AppColors.fats,
                                        Colors.white,
                                        0.75,
                                      )
                                    : Color.lerp(
                                        AppColors.protein,
                                        Colors.white,
                                        0.75,
                                      ),
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: Text(
                                '${changeInRange >= 0 ? '+' : ''}${changeInRange.toStringAsFixed(1)} kg',
                                style: TextStyle(
                                  color: changeIsDown
                                      ? AppColors.fats
                                      : AppColors.protein,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  OutlinedButton.icon(
                    onPressed: addWeightLog,
                    icon: const Icon(Icons.add, size: 18),
                    label: const Text('Add Log'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.orange,
                      side: const BorderSide(color: AppColors.orange),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _RangeButton(
                    label: '7D',
                    isSelected: selectedRange == WeightRange.sevenDays,
                    onTap: () {
                      setState(() {
                        selectedRange = WeightRange.sevenDays;
                      });
                    },
                  ),
                  const SizedBox(width: 8),
                  _RangeButton(
                    label: '30D',
                    isSelected: selectedRange == WeightRange.thirtyDays,
                    onTap: () {
                      setState(() {
                        selectedRange = WeightRange.thirtyDays;
                      });
                    },
                  ),
                  const SizedBox(width: 8),
                  _RangeButton(
                    label: '90D',
                    isSelected: selectedRange == WeightRange.ninetyDays,
                    onTap: () {
                      setState(() {
                        selectedRange = WeightRange.ninetyDays;
                      });
                    },
                  ),
                  const Spacer(),
                  Text(
                    selectedLabel,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: CustomPaint(
                        painter: _WeightGraphPainter(
                          values: currentLogs,
                          lineColor: AppColors.orange,
                          fillColor: Color.lerp(
                            AppColors.orange,
                            Colors.white,
                            0.82,
                          )!,
                          gridColor: AppColors.tempgrey,
                        ),
                        child: Container(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: xAxisLabels
                          .map(
                            (label) => Expanded(
                              child: Text(
                                label,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
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

class _AddWeightLogDialog extends StatefulWidget {
  const _AddWeightLogDialog();

  @override
  State<_AddWeightLogDialog> createState() => _AddWeightLogDialogState();
}

class _AddWeightLogDialogState extends State<_AddWeightLogDialog> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add weight log'),
      content: TextField(
        controller: controller,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        decoration: const InputDecoration(hintText: '70.8', suffixText: 'kg'),
        autofocus: true,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            final parsed = double.tryParse(controller.text.trim());
            Navigator.pop(context, parsed);
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}

class _RangeButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _RangeButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.orange : AppColors.tempgrey,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : AppColors.darkbrown,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _WeightGraphPainter extends CustomPainter {
  final List<double> values;
  final Color lineColor;
  final Color fillColor;
  final Color gridColor;

  const _WeightGraphPainter({
    required this.values,
    required this.lineColor,
    required this.fillColor,
    required this.gridColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (values.isEmpty || size.isEmpty) {
      return;
    }

    final minValue = values.reduce((a, b) => a < b ? a : b);
    final maxValue = values.reduce((a, b) => a > b ? a : b);
    final paddedMin = minValue - 0.4;
    final paddedMax = maxValue + 0.4;
    final range = (paddedMax - paddedMin).clamp(0.1, double.infinity);
    final stepX = values.length == 1 ? 0.0 : size.width / (values.length - 1);

    final points = <Offset>[];
    for (var i = 0; i < values.length; i++) {
      final normalizedY = (values[i] - paddedMin) / range;
      final dy = size.height - (normalizedY * size.height);
      points.add(Offset(stepX * i, dy));
    }

    final gridPaint = Paint()
      ..color = gridColor
      ..strokeWidth = 1;

    for (var i = 1; i <= 3; i++) {
      final y = size.height * (i / 4);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    final linePath = Path()..moveTo(points.first.dx, points.first.dy);
    for (var i = 1; i < points.length; i++) {
      final previous = points[i - 1];
      final current = points[i];
      final controlX = (previous.dx + current.dx) / 2;
      linePath.cubicTo(
        controlX,
        previous.dy,
        controlX,
        current.dy,
        current.dx,
        current.dy,
      );
    }

    final fillPath = Path.from(linePath)
      ..lineTo(points.last.dx, size.height)
      ..lineTo(points.first.dx, size.height)
      ..close();

    canvas.drawPath(
      fillPath,
      Paint()
        ..color = fillColor
        ..style = PaintingStyle.fill,
    );

    canvas.drawPath(
      linePath,
      Paint()
        ..color = lineColor
        ..strokeWidth = 3
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round,
    );

    final dotPaint = Paint()..color = lineColor;
    final dotFillPaint = Paint()..color = Colors.white;
    for (final point in points) {
      canvas.drawCircle(point, 4.5, dotPaint);
      canvas.drawCircle(point, 2.3, dotFillPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _WeightGraphPainter oldDelegate) {
    return oldDelegate.values != values ||
        oldDelegate.lineColor != lineColor ||
        oldDelegate.fillColor != fillColor ||
        oldDelegate.gridColor != gridColor;
  }
}
