import 'package:flutter/material.dart';
import 'package:mobile/core/theme/app_colors.dart';
import 'package:mobile/core/widgets/app_card.dart';
import 'package:mobile/core/widgets/app_primary_button.dart';
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
  final TextEditingController _notesController = TextEditingController();

  final StartRouteService _startRouteService = StartRouteService();

  String? _selectedVehicle = 'carro';
  String? _selectedShift = 'manha';
  bool _isSubmitting = false;

  @override
  void dispose() {
    _routeNameController.dispose();
    _bagController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _startRoute() async {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) return;

    final draft = RouteDraft(
      routeName: _routeNameController.text.trim(),
      vehicleType: _selectedVehicle!,
      shift: _selectedShift!,
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

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Route #${createdRoute.id} started successfully'),
        ),
      );

      Navigator.of(context).pushReplacementNamed(
        AppRoutes.activeRoute,
        arguments: createdRoute,
      );
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to start route: $error'),
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
      return '$fieldName is required';
    }

    return null;
  }

  String? _validateDropdown(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Start Route'),
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
                          'Route details',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'Fill in the operational details before enabling location tracking.',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.textSecondary,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 18),
                        RouteTextField(
                          label: 'Route name',
                          hintText: 'e.g. Morning Collection Route',
                          controller: _routeNameController,
                          prefixIcon: Icons.route_rounded,
                          validator: (value) =>
                              _validateRequiredText(value, 'Route name'),
                        ),
                        const SizedBox(height: 16),
                        RouteDropdownField<String>(
                          label: 'Vehicle type',
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
                            setState(() {
                              _selectedVehicle = value;
                            });
                          },
                          validator: (value) =>
                              _validateDropdown(value, 'Vehicle type'),
                        ),
                        const SizedBox(height: 16),
                        RouteDropdownField<String>(
                          label: 'Shift',
                          value: _selectedShift,
                          prefixIcon: Icons.schedule_rounded,
                          items: const [
                            DropdownMenuItem(
                              value: 'manha',
                              child: Text('Manhã'),
                            ),
                            DropdownMenuItem(
                              value: 'tarde',
                              child: Text('Tarde'),
                            ),
                            DropdownMenuItem(
                              value: 'noite',
                              child: Text('Noite'),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _selectedShift = value;
                            });
                          },
                          validator: (value) =>
                              _validateDropdown(value, 'Shift'),
                        ),
                        const SizedBox(height: 16),
                        RouteTextField(
                          label: 'Bag / container ID',
                          hintText: 'e.g. BAG-01',
                          controller: _bagController,
                          prefixIcon: Icons.inventory_2_rounded,
                          validator: (value) =>
                              _validateRequiredText(value, 'Bag / container ID'),
                        ),
                        const SizedBox(height: 16),
                        RouteTextField(
                          label: 'Notes',
                          hintText: 'Add any operational note for this route',
                          controller: _notesController,
                          prefixIcon: Icons.notes_rounded,
                          maxLines: 4,
                        ),
                        const SizedBox(height: 22),
                        AppPrimaryButton(
                          label: _isSubmitting ? 'Starting...' : 'Start route',
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
            'Initialize transport',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w800,
              height: 1.15,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Define vehicle, bag and route context before starting field operations.',
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