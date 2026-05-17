import 'package:flutter/material.dart';
import 'package:mobile/core/l10n/app_strings.dart';
import 'package:mobile/core/theme/app_colors.dart';
import 'package:mobile/core/widgets/app_card.dart';
import 'package:mobile/core/widgets/app_primary_button.dart';
import 'package:mobile/features/auth/domain/models/auth_user.dart';
import 'package:mobile/features/start_route/data/services/start_route_service.dart';
import 'package:mobile/features/start_route/domain/models/route_draft.dart';
import 'package:mobile/features/start_route/presentation/widgets/route_dropdown_field.dart';
import 'package:mobile/features/start_route/presentation/widgets/route_text_field.dart';
import 'package:mobile/app/routes.dart';

class StartRouteScreen extends StatefulWidget {
  const StartRouteScreen({super.key});

  @override
  State<StartRouteScreen> createState() => _StartRouteScreenState();
}

class _StartRouteScreenState extends State<StartRouteScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _routeNameController = TextEditingController();
  final TextEditingController _bagController = TextEditingController();
  final TextEditingController _shiftController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  final StartRouteService _startRouteService = StartRouteService();

  String _selectedVehicle = 'moto';
  late final String _selectedShift;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _selectedShift = _inferShift(now);
    _shiftController.text = _formatShift(_selectedShift);
    _routeNameController.text = _generateRouteName(now);
    _bagController.text = _generateBagId(now);
  }

  @override
  void dispose() {
    _routeNameController.dispose();
    _bagController.dispose();
    _shiftController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  String _inferShift(DateTime dateTime) {
    final hour = dateTime.hour;
    if (hour >= 6 && hour <= 11) return 'manha';
    if (hour >= 12 && hour <= 17) return 'tarde';
    return 'noite';
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

  String _timestampToken(DateTime dateTime) {
    final year = dateTime.year.toString().padLeft(4, '0');
    final month = dateTime.month.toString().padLeft(2, '0');
    final day = dateTime.day.toString().padLeft(2, '0');
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');
    return '$year$month$day-$hour$minute';
  }

  String _generateRouteName(DateTime dateTime) {
    return 'Rota-${_timestampToken(dateTime)}';
  }

  String _generateBagId(DateTime dateTime) {
    return 'BAG-${_timestampToken(dateTime)}';
  }

  Future<void> _startRoute() async {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) return;

    final draft = RouteDraft(
      routeName: _routeNameController.text.trim(),
      vehicleType: _selectedVehicle,
      shift: _selectedShift,
      bagId: _bagController.text.trim(),
      notes: _notesController.text.trim(),
      createdAt: DateTime.now(),
    );

    setState(() {
      _isSubmitting = true;
    });

    try {
      final createdRoute = await _startRouteService.createRoute(draft);

      if (!mounted) return;

      final driverUser =
          ModalRoute.of(context)?.settings.arguments as AuthUser?;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${AppStrings.routeStartedSuccessfully} #${createdRoute.id}'),
        ),
      );

      Navigator.of(context).pushReplacementNamed(
        AppRoutes.activeRoute,
        arguments: {
          'route': createdRoute,
          'driverUser': driverUser,
        },
      );
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${AppStrings.startRouteError}: $error'),
        ),
      );
    } finally {
      if (!mounted) return;

      setState(() {
        _isSubmitting = false;
      });
    }
  }

  String? _validateRequiredText(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName ${AppStrings.requiredSuffix}';
    }

    return null;
  }

  String? _validateDropdown(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName ${AppStrings.requiredSuffix}';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.startRouteTitle),
        backgroundColor: Colors.transparent,
      ),
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
          top: false,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _StartRouteHero(),
                  const SizedBox(height: 20),
                  AppCard(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          AppStrings.routeDetailsTitle,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          AppStrings.routeDetailsDescription,
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.textSecondary,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 18),
                        RouteTextField(
                          label: AppStrings.routeNameGeneratedLabel,
                          hintText: AppStrings.routeNameGeneratedHint,
                          controller: _routeNameController,
                          prefixIcon: Icons.route_rounded,
                          readOnly: true,
                          validator: (value) =>
                              _validateRequiredText(
                                value,
                                AppStrings.routeNameGeneratedLabel,
                              ),
                        ),
                        const SizedBox(height: 16),
                        RouteDropdownField<String>(
                          label: AppStrings.vehicleTypeLabel,
                          value: _selectedVehicle,
                          prefixIcon: Icons.local_shipping_rounded,
                          items: const [
                            DropdownMenuItem(
                              value: 'carro',
                              child: Text('Carro'),
                            ),
                            DropdownMenuItem(
                              value: 'moto',
                              child: Text('Moto'),
                            ),
                            DropdownMenuItem(
                              value: 'caminhao',
                              child: Text('Caminhão'),
                            ),
                          ],
                          onChanged: (value) {
                            if (value == null) return;
                            setState(() {
                              _selectedVehicle = value;
                            });
                          },
                          validator: (value) =>
                              _validateDropdown(
                                value,
                                AppStrings.vehicleTypeLabel,
                              ),
                        ),
                        const SizedBox(height: 16),
                        RouteTextField(
                          label: AppStrings.shiftLabelAuto,
                          hintText: AppStrings.shiftAutoHint,
                          controller: _shiftController,
                          prefixIcon: Icons.schedule_rounded,
                          readOnly: true,
                        ),
                        const SizedBox(height: 16),
                        RouteTextField(
                          label: AppStrings.bagIdLabel,
                          hintText: AppStrings.bagIdGeneratedHint,
                          controller: _bagController,
                          prefixIcon: Icons.inventory_2_rounded,
                          readOnly: true,
                          validator: (value) =>
                              _validateRequiredText(
                                value,
                                AppStrings.bagIdLabel,
                              ),
                        ),
                        const SizedBox(height: 16),
                        RouteTextField(
                          label: AppStrings.notes,
                          hintText: AppStrings.routeNotesHint,
                          controller: _notesController,
                          prefixIcon: Icons.notes_rounded,
                          maxLines: 4,
                        ),
                        const SizedBox(height: 22),
                        AppPrimaryButton(
                          label: _isSubmitting
                              ? AppStrings.startRouteInProgress
                              : AppStrings.startRoute,
                          icon: _isSubmitting
                              ? Icons.hourglass_top_rounded
                              : Icons.play_arrow_rounded,
                          onPressed: _isSubmitting ? null : _startRoute,
                        ),
                      ],
                    ),
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

class _StartRouteHero extends StatelessWidget {
  const _StartRouteHero();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.initializeTransportTitle,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w800,
              height: 1.15,
            ),
          ),
          SizedBox(height: 10),
          Text(
            AppStrings.initializeTransportDescription,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}
