import 'package:flutter/material.dart';
import 'package:mobile/core/l10n/app_strings.dart';
import 'package:mobile/core/theme/app_colors.dart';
import 'package:mobile/core/widgets/app_card.dart';
import 'package:mobile/core/widgets/app_primary_button.dart';
import 'package:mobile/features/collection/data/services/collection_service.dart';
import 'package:mobile/features/collection/domain/models/collection_draft.dart';
import 'package:mobile/features/collection/presentation/widgets/collection_text_field.dart';

class AddCollectionScreen extends StatefulWidget {
  const AddCollectionScreen({super.key});

  @override
  State<AddCollectionScreen> createState() => _AddCollectionScreenState();
}

class _AddCollectionScreenState extends State<AddCollectionScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _temperatureController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  final CollectionService _collectionService = CollectionService();

  bool _isSubmitting = false;

  @override
  void dispose() {
    _locationController.dispose();
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

  Future<void> _useCurrentLocation() async {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(AppStrings.locationCaptureNotImplemented),
      ),
    );
  }

  Future<void> _submit(int routeId) async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    final draft = CollectionDraft(
      routeId: routeId,
      locationName: _locationController.text.trim(),
      temperature: _temperatureController.text.trim().replaceAll(',', '.'),
      notes: _notesController.text.trim(),
      collectedAt: DateTime.now(),
    );

    setState(() {
      _isSubmitting = true;
    });

    try {
      final createdCollection = await _collectionService.createCollection(draft);

      if (!mounted) return;
      Navigator.of(context).pop(createdCollection);
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${AppStrings.addCollectionError}: $error'),
        ),
      );
    } finally {
      if (!mounted) return;

      setState(() {
        _isSubmitting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final routeId = ModalRoute.of(context)!.settings.arguments as int;

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.addCollectionScreenTitle),
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
                  const _AddCollectionHero(),
                  const SizedBox(height: 20),
                  AppCard(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          AppStrings.collectionDetailsTitle,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          AppStrings.collectionDetailsDescription,
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.textSecondary,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          AppStrings.collectionLocationPreparationDescription,
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.textSecondary,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 18),
                        CollectionTextField(
                          label: AppStrings.locationNameLabel,
                          hintText: AppStrings.locationNameHint,
                          controller: _locationController,
                          prefixIcon: Icons.location_on_rounded,
                          validator: (value) =>
                              _validateRequiredText(
                                value,
                                AppStrings.locationNameLabel,
                              ),
                        ),
                        const SizedBox(height: 12),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: OutlinedButton.icon(
                            onPressed: _isSubmitting ? null : _useCurrentLocation,
                            icon: const Icon(Icons.my_location_rounded),
                            label: const Text(AppStrings.useCurrentLocation),
                          ),
                        ),
                        const SizedBox(height: 16),
                        CollectionTextField(
                          label: AppStrings.collectionTemperatureFieldLabel,
                          hintText: AppStrings.collectionTemperatureHint,
                          controller: _temperatureController,
                          prefixIcon: Icons.thermostat_rounded,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          validator: _validateTemperature,
                        ),
                        const SizedBox(height: 16),
                        CollectionTextField(
                          label: AppStrings.notes,
                          hintText: AppStrings.collectionNotesHint,
                          controller: _notesController,
                          prefixIcon: Icons.notes_rounded,
                          maxLines: 4,
                        ),
                        const SizedBox(height: 22),
                        AppPrimaryButton(
                          label: _isSubmitting
                              ? AppStrings.saveCollectionInProgress
                              : AppStrings.saveCollection,
                          icon: _isSubmitting
                              ? Icons.hourglass_top_rounded
                              : Icons.check_circle_outline_rounded,
                          onPressed: _isSubmitting ? null : () => _submit(routeId),
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

class _AddCollectionHero extends StatelessWidget {
  const _AddCollectionHero();

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
            AppStrings.registerPickupTitle,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w800,
              height: 1.15,
            ),
          ),
          SizedBox(height: 10),
          Text(
            AppStrings.registerPickupDescription,
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
