import 'package:flutter/material.dart';
import 'package:mobile/app/routes.dart';
import 'package:mobile/core/l10n/app_strings.dart';
import 'package:mobile/core/theme/app_colors.dart';
import 'package:mobile/features/auth/data/services/auth_service.dart';
import 'package:mobile/features/auth/domain/models/auth_user.dart';
import 'package:mobile/features/receiver/data/services/receiver_service.dart';
import 'package:mobile/features/start_route/data/dto/route_response_dto.dart';

class ReceiverHomeScreen extends StatefulWidget {
  final AuthUser user;

  const ReceiverHomeScreen({
    super.key,
    required this.user,
  });

  @override
  State<ReceiverHomeScreen> createState() => _ReceiverHomeScreenState();
}

class _ReceiverHomeScreenState extends State<ReceiverHomeScreen> {
  final ReceiverService _receiverService = ReceiverService();

  bool _isLoading = true;
  List<RouteResponseDto> _pendingRoutes = [];

  @override
  void initState() {
    super.initState();
    _loadPendingRoutes();
  }

  Future<void> _loadPendingRoutes() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final routes = await _receiverService.fetchPendingReceivingRoutes();

      if (!mounted) return;

      setState(() {
        _pendingRoutes = routes;
      });
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${AppStrings.pendingRoutesLoadError} $error'),
        ),
      );
    } finally {
      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });
    }
  }

  void _logout() {
    AuthService().logout();

    Navigator.of(context).pushNamedAndRemoveUntil(
      AppRoutes.login,
      (route) => false,
    );
  }

  Future<void> _openReceiving(RouteResponseDto route) async {
    final result = await Navigator.of(context).pushNamed(
      AppRoutes.receiving,
      arguments: route,
    );

    if (result == true) {
      await _loadPendingRoutes();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(AppStrings.receivingRegisteredSuccessfully),
        ),
      );
    }
  }

  String _formatDateTime(DateTime? value) {
    if (value == null) return '--';

    final day = value.day.toString().padLeft(2, '0');
    final month = value.month.toString().padLeft(2, '0');
    final hour = value.hour.toString().padLeft(2, '0');
    final minute = value.minute.toString().padLeft(2, '0');

    return '$day/$month • $hour:$minute';
  }

  String _formatVehicle(String value) {
    switch (value) {
      case 'carro':
        return 'Carro';
      case 'moto':
        return 'Moto';
      case 'caminhao':
        return 'Caminhão';
      default:
        return value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
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
          child: RefreshIndicator(
            onRefresh: _loadPendingRoutes,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ReceiverHeader(
                    username: widget.user.username,
                    onLogout: _logout,
                  ),
                  const SizedBox(height: 26),
                  _QueueHeroCard(
                    pendingCount: _pendingRoutes.length,
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    AppStrings.pendingReceivingTitle,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (_isLoading)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(32),
                        child: CircularProgressIndicator(),
                      ),
                    )
                  else if (_pendingRoutes.isEmpty)
                    const _EmptyReceivingState()
                  else
                    Column(
                      children: _pendingRoutes
                          .map(
                            (route) => Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: _PendingRouteCard(
                                routeName: route.routeName,
                                vehicle: _formatVehicle(route.vehicleType),
                                bagId: route.bagId,
                                finishedAt: _formatDateTime(route.finishedAt),
                                collectionsCount:
                                    route.collectionsCount.toString(),
                                onTap: () => _openReceiving(route),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ReceiverHeader extends StatelessWidget {
  final String username;
  final VoidCallback onLogout;

  const _ReceiverHeader({
    required this.username,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withAlpha(55),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: const Icon(
            Icons.assignment_turned_in_rounded,
            color: Colors.white,
            size: 28,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                AppStrings.receiverMode,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                username,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
        IconButton.filledTonal(
          onPressed: onLogout,
          icon: const Icon(Icons.logout_rounded),
          tooltip: AppStrings.logoutButton,
        ),
      ],
    );
  }
}

class _QueueHeroCard extends StatelessWidget {
  final int pendingCount;

  const _QueueHeroCard({
    required this.pendingCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF0F172A),
            Color(0xFF1E293B),
            Color(0xFF334155),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(40),
            blurRadius: 26,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            AppStrings.receivingQueueTitle,
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.w900,
              height: 1.08,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            AppStrings.receivingQueueDescription,
            style: TextStyle(
              color: Colors.white.withAlpha(220),
              fontSize: 15,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 22),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(20),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: Colors.white.withAlpha(22),
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.inventory_2_rounded,
                  color: Colors.white,
                ),
                const SizedBox(width: 12),
                Text(
                  '$pendingCount ${AppStrings.routesWaitingSuffix}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PendingRouteCard extends StatelessWidget {
  final String routeName;
  final String vehicle;
  final String bagId;
  final String finishedAt;
  final String collectionsCount;
  final VoidCallback onTap;

  const _PendingRouteCard({
    required this.routeName,
    required this.vehicle,
    required this.bagId,
    required this.finishedAt,
    required this.collectionsCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppColors.border),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(8),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: AppColors.primarySoft,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Icon(
                  Icons.route_rounded,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      routeName,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '$vehicle • ${AppStrings.bagLabel} $bagId • $collectionsCount ${AppStrings.collectionsLabel}',
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${AppStrings.finishedLabel}: $finishedAt',
                      style: const TextStyle(
                        color: AppColors.textTertiary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: AppColors.textTertiary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyReceivingState extends StatelessWidget {
  const _EmptyReceivingState();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border),
      ),
      child: const Column(
        children: [
          Icon(
            Icons.check_circle_outline_rounded,
            size: 44,
            color: AppColors.textTertiary,
          ),
          SizedBox(height: 12),
          Text(
            AppStrings.noRoutesWaitingTitle,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 6),
          Text(
            AppStrings.noRoutesWaitingDescription,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: AppColors.textSecondary,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
