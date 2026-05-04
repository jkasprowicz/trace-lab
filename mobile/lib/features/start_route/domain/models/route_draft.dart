class RouteDraft {
  final String routeName;
  final String vehicleType;
  final String shift;
  final String bagId;
  final String notes;
  final DateTime createdAt;

  const RouteDraft({
    required this.routeName,
    required this.vehicleType,
    required this.shift,
    required this.bagId,
    required this.notes,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'route_name': routeName,
      'vehicle_type': vehicleType,
      'shift': shift,
      'bag_id': bagId,
      'notes': notes,
      'started_at': createdAt.toIso8601String(),
    };
  }
}