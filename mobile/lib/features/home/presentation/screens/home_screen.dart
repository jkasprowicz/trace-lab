import 'package:flutter/material.dart';
import 'package:mobile/core/theme/app_colors.dart';
import 'package:mobile/core/widgets/app_primary_button.dart';
import 'package:mobile/core/widgets/app_section_title.dart';
import 'package:mobile/features/home/presentation/widgets/dashboard_card.dart';
import 'package:mobile/features/home/presentation/widgets/quick_action_tile.dart';
import 'package:mobile/app/routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFEAF2FF),
              Color(0xFFF4F7FB),
              Color(0xFFFFFFFF),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _HomeHeader(),
                const SizedBox(height: 28),
                Text(
                  'Good evening, João',
                  style: theme.textTheme.headlineMedium,
                ),
                const SizedBox(height: 10),
                Text(
                  'Track routes, sample collections, temperature events and receiving logs in one place.',
                  style: theme.textTheme.bodyLarge,
                ),
                const SizedBox(height: 24),
                const _HeroCard(),
                const SizedBox(height: 24),
                const AppSectionTitle(title: 'Today overview'),
                const SizedBox(height: 14),
                const Row(
                  children: [
                    Expanded(
                      child: DashboardCard(
                        icon: Icons.route_rounded,
                        title: 'Routes',
                        value: '03',
                        subtitle: 'planned today',
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: DashboardCard(
                        icon: Icons.thermostat_rounded,
                        title: 'Temp logs',
                        value: '12',
                        subtitle: 'captured',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Row(
                  children: [
                    Expanded(
                      child: DashboardCard(
                        icon: Icons.location_on_rounded,
                        title: 'Tracking',
                        value: 'Live',
                        subtitle: 'available',
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: DashboardCard(
                        icon: Icons.inventory_2_rounded,
                        title: 'Status',
                        value: 'Ready',
                        subtitle: 'to start',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const AppSectionTitle(title: 'Quick actions'),
                const SizedBox(height: 14),
                QuickActionTile(
                  icon: Icons.play_circle_fill_rounded,
                  title: 'Start route',
                  subtitle: 'Create a new route and begin tracking.',
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.startRoute);
                  },
                ),
                const SizedBox(height: 12),
                QuickActionTile(
                  icon: Icons.add_location_alt_rounded,
                  title: 'Register collection',
                  subtitle: 'Log pickup point, temperature and notes.',
                  onTap: () {},
                ),
                const SizedBox(height: 12),
                QuickActionTile(
                  icon: Icons.assignment_turned_in_rounded,
                  title: 'Finish receiving',
                  subtitle: 'Confirm delivery and register final temperature.',
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HomeHeader extends StatelessWidget {
  const _HomeHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColors.primary,
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withAlpha(60),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: const Icon(
            Icons.biotech_rounded,
            color: Colors.white,
            size: 24,
          ),
        ),
        const SizedBox(width: 14),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'TraceLab',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'Sample transport intelligence',
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(230),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.border),
          ),
          child: const Icon(
            Icons.notifications_none_rounded,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          colors: [
            AppColors.primaryDark,
            AppColors.primary,
            Color(0xFF3B82F6),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withAlpha(70),
            blurRadius: 28,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(35),
              borderRadius: BorderRadius.circular(99),
            ),
            child: const Text(
              'No active route',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'Ready to begin a new transport route?',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w800,
              height: 1.15,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Start a route, enable live location tracking and record temperature at every pickup point.',
            style: TextStyle(
              color: Colors.white.withAlpha(225),
              fontSize: 14,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 22),
          AppPrimaryButton(
            label: 'Start route',
            icon: Icons.play_arrow_rounded,
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.startRoute);
            },
          ),
        ],
      ),
    );
  }
}