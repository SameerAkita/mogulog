import 'package:flutter/material.dart';
import 'package:mogulog/theme/app_colors.dart';

class MacroCardWidget extends StatefulWidget {
  final IconData iconData;
  final Color color;
  final String title;
  final int amount;

  const MacroCardWidget({
    super.key,
    required this.iconData,
    required this.color,
    required this.title,
    required this.amount,
  });

  @override
  State<MacroCardWidget> createState() => _MacroCardWidgetState();
}

class _MacroCardWidgetState extends State<MacroCardWidget> {
  @override
  bool showFixedContent = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.easeOut,
      transitionBuilder: (child, animation) {
        final offsetAnimation = Tween(
          begin: const Offset(0, 1),
          end: Offset.zero,
        ).animate(animation);

        return SlideTransition(position: offsetAnimation, child: child);
      },
      child: _fixedContent(),
    );
  }

  Widget _fixedContent() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.tempgrey,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Icon(widget.iconData, color: widget.color),
            ),
          ),
          SizedBox(width: 8),

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.title, style: TextStyle(fontSize: 18)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${widget.amount}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Icon(
                        Icons.edit,
                        color: AppColors.lightgrey,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
