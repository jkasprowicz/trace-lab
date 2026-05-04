import 'package:flutter/material.dart';
import 'package:mobile/core/theme/app_colors.dart';
import 'package:mobile/core/widgets/app_card.dart';

class ActiveRouteSummaryCard extends StatelessWidget {
  final String vehicle;
  final String shift;
  final String bagId;
  final String collectionsCount;

  const ActiveRouteSummaryCard({
    super.key,
    required this.vehicle,
    required this.shift,
    required this.bagId,
    required this.collectionsCount,
  });

  Widget _infoItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.primarySoft,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: AppColors.primary, size: 20),
            const SizedBox(height: 10),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                fontSize: 15,
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Operational summary',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Live route context and transport metadata.',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _infoItem(
                icon: Icons.local_shipping_rounded,
                label: 'Vehicle',
                value: vehicle,
              ),
              const SizedBox(width: 12),
              _infoItem(
                icon: Icons.schedule_rounded,
                label: 'Shift',
                value: shift,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _infoItem(
                icon: Icons.inventory_2_rounded,
                label: 'Bag ID',
                value: bagId,
              ),
              const SizedBox(width: 12),
              _infoItem(
                icon: Icons.add_location_alt_rounded,
                label: 'Collections',
                value: collectionsCount,
              ),
            ],
          ),
        ],
      ),
    );
  }
}