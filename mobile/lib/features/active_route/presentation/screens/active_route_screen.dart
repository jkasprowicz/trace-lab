import 'package:flutter/material.dart';
import 'package:mobile/app/routes.dart';
import 'package:mobile/core/theme/app_colors.dart';
import 'package:mobile/core/widgets/app_primary_button.dart';
import 'package:mobile/core/widgets/app_section_title.dart';
import 'package:mobile/features/active_route/data/services/active_route_service.dart';
import 'package:mobile/features/active_route/presentation/widgets/active_route_header.dart';
import 'package:mobile/features/active_route/presentation/widgets/active_route_summary_card.dart';
import 'package:mobile/features/active_route/presentation/widgets/collection_timeline_tile.dart';
import 'package:mobile/features/collection/data/dto/collection_response_dto.dart';
import 'package:mobile/features/collection/data/services/collection_service.dart';
import 'package:mobile/features/start_route/data/dto/route_response_dto.dart';

class ActiveRouteScreen extends StatefulWidget {
  const ActiveRouteScreen({super.key});

  @override
  State<ActiveRouteScreen> createState() => _ActiveRouteScreenState();
}

class _ActiveRouteScreenState extends State<ActiveRouteScreen> {
  final CollectionService _collectionService = CollectionService();
  final ActiveRouteService _activeRouteService = ActiveRouteService();

  bool _isLoadingCollections = true;
  bool _isFinishingRoute = false;
  List<CollectionResponseDto> _collections = [];
  late RouteResponseDto _route;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _route = ModalRoute.of(context)!.settings.arguments as RouteResponseDto;
    _loadCollections();
  }

  bool get _isRouteFinished => _route.status == 'finished';

  Future<void> _loadCollections() async {
    setState(() {
      _isLoadingCollections = true;
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
        _isLoadingCollections = false;
      });
    }
  }

  Future<void> _goToAddCollection() async {
    if (_isRouteFinished) return;

    final result = await Navigator.of(context).pushNamed(
      AppRoutes.addCollection,
      arguments: _route.id,
    );

    if (result is CollectionResponseDto) {
      await _loadCollections();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Collection added successfully'),
        ),
      );
    }
  }

  Future<void> _finishRoute() async {
    if (_isRouteFinished || _isFinishingRoute) return;

    final shouldFinish = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Finish route'),
              content: const Text(
                'Are you sure you want to finish this route? '
                'After finishing, no new collections can be added.',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Cancel'),
                ),
                FilledButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Finish'),
                ),
              ],
            );
          },
        ) ??
        false;

    if (!shouldFinish) return;

    setState(() {
      _isFinishingRoute = true;
    });

    try {
      final finishedRoute = await _activeRouteService.finishRoute(_route.id);

      if (!mounted) return;

      setState(() {
        _route = finishedRoute;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Route finished successfully'),
        ),
      );

      Navigator.of(context).pushReplacementNamed(
        AppRoutes.routeSummary,
        arguments: finishedRoute,
      );
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to finish route: $error'),
        ),
      );
    } finally {
      if (!mounted) return;

      setState(() {
        _isFinishingRoute = false;
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

  String _formatTemperature(String value) {
    return '$value°C';
  }

  String _formatTime(DateTime value) {
    final hour = value.hour.toString().padLeft(2, '0');
    final minute = value.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
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
                ActiveRouteHeader(
                  routeName: _route.routeName,
                  statusLabel: _isRouteFinished ? 'ROUTE FINISHED' : 'LIVE ROUTE',
                  elapsedLabel: _isRouteFinished ? 'Closed' : 'Started now',
                ),
                const SizedBox(height: 20),
                ActiveRouteSummaryCard(
                  vehicle: _formatVehicle(_route.vehicleType),
                  shift: _formatShift(_route.shift),
                  bagId: _route.bagId,
                  collectionsCount: _collections.length.toString(),
                ),
                const SizedBox(height: 20),
                AppPrimaryButton(
                  label: _isRouteFinished
                      ? 'Route finished'
                      : 'Add collection',
                  icon: _isRouteFinished
                      ? Icons.lock_outline_rounded
                      : Icons.add_location_alt_rounded,
                  onPressed: _isRouteFinished ? null : _goToAddCollection,
                ),
                const SizedBox(height: 24),
                const AppSectionTitle(title: 'Collection timeline'),
                const SizedBox(height: 12),
                if (_isLoadingCollections)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(24),
                      child: CircularProgressIndicator(),
                    ),
                  )
                else if (_collections.isEmpty)
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
                          'No collections registered yet',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'Start by adding the first pickup event for this route.',
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
                              temperature: _formatTemperature(collection.temperature),
                              timeLabel: _formatTime(collection.collectedAt),
                              notes: collection.notes,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                const SizedBox(height: 24),
                OutlinedButton.icon(
                  onPressed: _isRouteFinished || _isFinishingRoute
                      ? null
                      : _finishRoute,
                  icon: _isFinishingRoute
                      ? const Icon(Icons.hourglass_top_rounded)
                      : const Icon(Icons.stop_circle_outlined),
                  label: Text(
                    _isRouteFinished
                        ? 'Route finished'
                        : _isFinishingRoute
                            ? 'Finishing...'
                            : 'Finish route',
                  ),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 56),
                    foregroundColor: AppColors.textPrimary,
                    side: const BorderSide(color: AppColors.border),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    backgroundColor: Colors.white,
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