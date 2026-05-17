import 'package:flutter/material.dart';
import 'package:mobile/core/l10n/app_strings.dart';
import 'package:mobile/core/theme/app_colors.dart';
import 'package:mobile/core/widgets/app_card.dart';
import 'package:mobile/core/widgets/app_primary_button.dart';
import 'package:mobile/features/auth/domain/models/auth_user.dart';
import 'package:mobile/features/receiver/presentation/screens/receiver_home_screen.dart';
import 'package:mobile/features/receiving/data/services/receiving_service.dart';
import 'package:mobile/features/receiving/domain/models/receiving_draft.dart';
import 'package:mobile/features/receiving/presentation/widgets/receiving_dropdown_field.dart';
import 'package:mobile/features/receiving/presentation/widgets/receiving_text_field.dart';
import 'package:mobile/features/start_route/data/dto/route_response_dto.dart';

class ReceivingScreen extends StatefulWidget {
  const ReceivingScreen({super.key});

  @override
  State<ReceivingScreen> createState() => _ReceivingScreenState();
}

class _ReceivingScreenState extends State<ReceivingScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _receiverNameController = TextEditingController();
  final TextEditingController _temperatureController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  final ReceivingService _receivingService = ReceivingService();

  String? _selectedIntegrityStatus = 'ok';
  bool _isSubmitting = false;
  bool _isSuccess = false;

  @override
  void dispose() {
    _receiverNameController.dispose();
    _temperatureController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  String? _validateRequiredText(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName ${AppStrings.requiredSuffix}';
    }
    return null;
  }

  String? _validateTemperature(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.temperatureRequired;
    }

    final normalized = value.replaceAll(',', '.');
    final parsed = double.tryParse(normalized);

    if (parsed == null) {
      return AppStrings.invalidTemperature;
    }

    return null;
  }

  Future<void> _submit(RouteResponseDto route) async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    final draft = ReceivingDraft(
      routeId: route.id,
      receiverName: _receiverNameController.text.trim(),
      temperature: _temperatureController.text.trim().replaceAll(',', '.'),
      integrityStatus: _selectedIntegrityStatus!,
      notes: _notesController.text.trim(),
      receivedAt: DateTime.now(),
    );

    setState(() {
      _isSubmitting = true;
    });

    try {
      await _receivingService.createReceiving(draft);

      if (!mounted) return;

      setState(() {
        _isSubmitting = false;
        _isSuccess = true;
      });
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${AppStrings.receivingSaveError}: $error'),
        ),
      );
      setState(() {
        _isSubmitting = false;
      });
    }
  }

  void _continueAfterSuccess(AuthUser? receiverUser) {
    if (receiverUser != null) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => ReceiverHomeScreen(user: receiverUser),
        ),
        (route) => false,
      );
      return;
    }

    Navigator.of(context).pop(true);
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

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    final argsMap = args is Map<String, dynamic> ? args : null;
    final route =
        (argsMap?['route'] as RouteResponseDto?) ?? args as RouteResponseDto;
    final receiverUser = argsMap?['receiverUser'] as AuthUser?;

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.receivingTitle),
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
            child: _isSuccess
                ? AppCard(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.check_circle_rounded,
                          color: Color(0xFF16A34A),
                          size: 56,
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          AppStrings.receivingSuccessTitle,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          AppStrings.receivingSuccessMessage,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.textSecondary,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 24),
                        AppPrimaryButton(
                          label: AppStrings.backToReceiverHome,
                          icon: Icons.home_rounded,
                          onPressed: () => _continueAfterSuccess(receiverUser),
                        ),
                      ],
                    ),
                  )
                : Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                AppStrings.registerReceivingTitle,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w800,
                                  height: 1.15,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                AppStrings.receivingIntro,
                                style: TextStyle(
                                  color: Colors.white.withAlpha(220),
                                  fontSize: 14,
                                  height: 1.45,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        AppCard(
                          padding: const EdgeInsets.all(18),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                AppStrings.routeContext,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text('${AppStrings.routeLabel}: ${route.routeName}'),
                              const SizedBox(height: 6),
                              Text('${AppStrings.vehicleLabel}: ${_formatVehicle(route.vehicleType)}'),
                              const SizedBox(height: 6),
                              Text('${AppStrings.shiftLabel}: ${_formatShift(route.shift)}'),
                              const SizedBox(height: 6),
                              Text('${AppStrings.bagIdLabel}: ${route.bagId}'),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        AppCard(
                          padding: const EdgeInsets.all(18),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                AppStrings.receivingDetails,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 6),
                              const Text(
                                AppStrings.receivingDetailsDescription,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.textSecondary,
                                  height: 1.4,
                                ),
                              ),
                              const SizedBox(height: 18),
                              ReceivingTextField(
                                label: AppStrings.receiverName,
                                hintText: AppStrings.receiverNameHint,
                                controller: _receiverNameController,
                                prefixIcon: Icons.person_rounded,
                                validator: (value) => _validateRequiredText(
                                  value,
                                  AppStrings.receiverName,
                                ),
                              ),
                              const SizedBox(height: 16),
                              ReceivingTextField(
                                label: AppStrings.receivingTemperatureLabel,
                                hintText: AppStrings.temperatureHint,
                                controller: _temperatureController,
                                prefixIcon: Icons.thermostat_rounded,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                  decimal: true,
                                ),
                                validator: _validateTemperature,
                              ),
                              const SizedBox(height: 16),
                              ReceivingDropdownField<String>(
                                label: AppStrings.integrityStatus,
                                value: _selectedIntegrityStatus,
                                prefixIcon: Icons.verified_rounded,
                                items: const [
                                  DropdownMenuItem(
                                    value: 'ok',
                                    child: Text(AppStrings.integrityStatusOk),
                                  ),
                                  DropdownMenuItem(
                                    value: 'restricted',
                                    child: Text(
                                      AppStrings.integrityStatusRestricted,
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: 'rejected',
                                    child: Text(
                                      AppStrings.integrityStatusRejected,
                                    ),
                                  ),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    _selectedIntegrityStatus = value;
                                  });
                                },
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return AppStrings.integrityStatusRequired;
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              ReceivingTextField(
                                label: AppStrings.notes,
                                hintText: AppStrings.notesHint,
                                controller: _notesController,
                                prefixIcon: Icons.notes_rounded,
                                maxLines: 4,
                              ),
                              const SizedBox(height: 22),
                              AppPrimaryButton(
                                label: _isSubmitting
                                    ? AppStrings.receivingSaveInProgress
                                    : AppStrings.confirmReceiving,
                                icon: _isSubmitting
                                    ? Icons.hourglass_top_rounded
                                    : Icons.check_circle_outline_rounded,
                                onPressed: _isSubmitting
                                    ? null
                                    : () => _submit(route),
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
