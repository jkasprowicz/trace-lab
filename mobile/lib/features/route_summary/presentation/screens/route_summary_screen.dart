import 'package:flutter/material.dart';
import 'package:mobile/app/routes.dart';
import 'package:mobile/core/l10n/app_strings.dart';
import 'package:mobile/core/theme/app_colors.dart';
import 'package:mobile/core/widgets/app_primary_button.dart';
import 'package:mobile/core/widgets/app_section_title.dart';
import 'package:mobile/features/active_route/presentation/widgets/collection_timeline_tile.dart';
import 'package:mobile/features/collection/data/dto/collection_response_dto.dart';
import 'package:mobile/features/collection/data/services/collection_service.dart';
import 'package:mobile/features/route_summary/presentation/widgets/summary_stat_card.dart';
import 'package:mobile/features/start_route/data/dto/route_response_dto.dart';

class RouteSummaryScreen extends StatefulWidget {
  const RouteSummaryScreen({super.key});

  @override
  State<RouteSummaryScreen> createState() => _RouteSummaryScreenState();
}

class _RouteSummaryScreenState extends State<RouteSummaryScreen> {
  final CollectionService _collectionService = CollectionService();

  bool _isLoading = true;
  List<CollectionResponseDto> _collections = [];
  late RouteResponseDto _route;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _route = ModalRoute.of(context)!.settings.arguments as RouteResponseDto;
    _loadCollections();
  }

  Future<void> _loadCollections() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final collections = await _collectionService.fetchCollections(_route.id);

      if (!mounted) return;

      setState(() {
        _collections = collections;
      });
    } catch (_) {
      if (!mounted) return;
    } finally {
      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });
    }
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

  String _formatShift(String value) {
    switch (value) {
      case 'manha':
        return 'Manhã';
      case 'tarde':
        return 'Tarde';
      case 'noite':
        return 'Noite';
      default:
        return value;
    }
  }

  String _formatDateTime(DateTime value) {
    final day = value.day.toString().padLeft(2, '0');
    final month = value.month.toString().padLeft(2, '0');
    final year = value.year.toString();
    final hour = value.hour.toString().padLeft(2, '0');
    final minute = value.minute.toString().padLeft(2, '0');

    return '$day/$month/$year • $hour:$minute';
  }

  String _formatTime(DateTime value) {
    final hour = value.hour.toString().padLeft(2, '0');
    final minute = value.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  double? _temperatureMin() {
    if (_collections.isEmpty) return null;

    final values = _collections
        .map((e) => double.tryParse(e.temperature))
        .whereType<double>()
        .toList();

    if (values.isEmpty) return null;
    values.sort();
    return values.first;
  }

  double? _temperatureMax() {
    if (_collections.isEmpty) return null;

    final values = _collections
        .map((e) => double.tryParse(e.temperature))
        .whereType<double>()
        .toList();

    if (values.isEmpty) return null;
    values.sort();
    return values.last;
  }

  double? _temperatureAvg() {
    if (_collections.isEmpty) return null;

    final values = _collections
        .map((e) => double.tryParse(e.temperature))
        .whereType<double>()
        .toList();

    if (values.isEmpty) return null;

    final sum = values.reduce((a, b) => a + b);
    return sum / values.length;
  }

  String _formatTemperatureValue(double? value) {
    if (value == null) return '--';
    return '${value.toStringAsFixed(1)}°C';
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
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
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
                        blurRadius: 24,
                        offset: const Offset(0, 14),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF22C55E).withAlpha(35),
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(
                            color: const Color(0xFF22C55E).withAlpha(80),
                          ),
                        ),
                        child: const Text(
                          'ROUTE FINISHED',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        _route.routeName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          height: 1.1,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Transport operation successfully completed. Review the route summary below.',
                        style: TextStyle(
                          color: Colors.white.withAlpha(220),
                          fontSize: 14,
                          height: 1.45,
                        ),
                      ),
                      const SizedBox(height: 18),
                      Text(
                        'Started: ${_formatDateTime(_route.startedAt)}',
                        style: TextStyle(
                          color: Colors.white.withAlpha(220),
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Finished: ${_route.finishedAt != null ? _formatDateTime(_route.finishedAt!) : '--'}',
                        style: TextStyle(
                          color: Colors.white.withAlpha(220),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                const AppSectionTitle(title: 'Operational summary'),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: SummaryStatCard(
                        icon: Icons.local_shipping_rounded,
                        label: 'Vehicle',
                        value: _formatVehicle(_route.vehicleType),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: SummaryStatCard(
                        icon: Icons.schedule_rounded,
                        label: 'Shift',
                        value: _formatShift(_route.shift),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: SummaryStatCard(
                        icon: Icons.inventory_2_rounded,
                        label: 'Bag ID',
                        value: _route.bagId,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: SummaryStatCard(
                        icon: Icons.add_location_alt_rounded,
                        label: 'Collections',
                        value: _collections.length.toString(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const AppSectionTitle(title: 'Temperature summary'),
                const SizedBox(height: 14),
                if (_isLoading)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(24),
                      child: CircularProgressIndicator(),
                    ),
                  )
                else ...[
                  Row(
                    children: [
                      Expanded(
                        child: SummaryStatCard(
                          icon: Icons.south_rounded,
                          label: 'Min',
                          value: _formatTemperatureValue(_temperatureMin()),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: SummaryStatCard(
                          icon: Icons.show_chart_rounded,
                          label: 'Avg',
                          value: _formatTemperatureValue(_temperatureAvg()),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: SummaryStatCard(
                          icon: Icons.north_rounded,
                          label: 'Max',
                          value: _formatTemperatureValue(_temperatureMax()),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const AppSectionTitle(title: 'Collection timeline'),
                  const SizedBox(height: 12),
                  if (_collections.isEmpty)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(22),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: const Column(
                        children: [
                          Icon(
                            Icons.route_rounded,
                            size: 42,
                            color: AppColors.textTertiary,
                          ),
                          SizedBox(height: 12),
                          Text(
                            'No collections registered',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            'This route was completed without collection records.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColors.textSecondary,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    Column(
                      children: _collections
                          .map(
                            (collection) => Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: CollectionTimelineTile(
                                locationName: collection.locationName,
                                temperature:
                                    '${collection.temperature}°C',
                                timeLabel:
                                    _formatTime(collection.collectedAt),
                                notes: collection.notes,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                ],
                const SizedBox(height: 24),
                AppPrimaryButton(
                  label: AppStrings.backToHome,
                  icon: Icons.home_rounded,
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      AppRoutes.home,
                      (route) => false,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
