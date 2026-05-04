import 'package:flutter/material.dart';
import 'package:mobile/core/theme/app_colors.dart';

class AppSectionTitle extends StatelessWidget {
  final String title;

  const AppSectionTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      ),
    );
  }
}