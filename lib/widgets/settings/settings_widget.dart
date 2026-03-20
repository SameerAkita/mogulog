import 'package:flutter/material.dart';
import 'package:mogulog/theme/app_colors.dart';

class SettingsWidget extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? leadingIcon;
  final VoidCallback? onTap;
  final Color? titleColor;
  final Color? iconColor;

  const SettingsWidget({
    super.key,
    required this.title,
    this.subtitle,
    this.leadingIcon,
    this.onTap,
    this.titleColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (leadingIcon != null) ...[
                Padding(
                  padding: const EdgeInsets.only(top: 1),
                  child: Icon(
                    leadingIcon,
                    size: 22,
                    color: iconColor ?? AppColors.darkbrown,
                  ),
                ),
                const SizedBox(width: 12),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(fontSize: 16, color: titleColor),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        subtitle!,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                          height: 1.35,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Icon(
                onTap == null ? Icons.remove : Icons.arrow_forward_ios,
                size: onTap == null ? 0 : 16,
                color: Colors.black45,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
