class CollectionDraft {
  final int routeId;
  final String locationName;
  final String temperature;
  final String notes;
  final DateTime collectedAt;

  const CollectionDraft({
    required this.routeId,
    required this.locationName,
    required this.temperature,
    required this.notes,
    required this.collectedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'location_name': locationName,
      'temperature': temperature,
      'notes': notes,
      'collected_at': collectedAt.toIso8601String(),
    };
  }
}