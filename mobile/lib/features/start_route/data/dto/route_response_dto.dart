class RouteResponseDto {
  final int id;
  final String routeName;
  final String vehicleType;
  final String shift;
  final String bagId;
  final String notes;
  final String status;
  final DateTime startedAt;
  final DateTime? finishedAt;
  final DateTime createdAt;
  final int collectionsCount;

  const RouteResponseDto({
    required this.id,
    required this.routeName,
    required this.vehicleType,
    required this.shift,
    required this.bagId,
    required this.notes,
    required this.status,
    required this.startedAt,
    required this.finishedAt,
    required this.createdAt,
    required this.collectionsCount,
  });

  factory RouteResponseDto.fromMap(Map<String, dynamic> map) {
    return RouteResponseDto(
      id: map['id'] as int,
      routeName: map['route_name'] as String,
      vehicleType: map['vehicle_type'] as String,
      shift: map['shift'] as String,
      bagId: map['bag_id'] as String,
      notes: (map['notes'] ?? '') as String,
      status: map['status'] as String,
      startedAt: DateTime.parse(map['started_at'] as String),
      finishedAt: map['finished_at'] != null
          ? DateTime.parse(map['finished_at'] as String)
          : null,
      createdAt: DateTime.parse(map['created_at'] as String),
      collectionsCount: (map['collections_count'] ?? 0) as int,
    );
  }
}