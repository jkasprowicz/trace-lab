class CollectionResponseDto {
  final int id;
  final int routeId;
  final String locationName;
  final String temperature;
  final String notes;
  final DateTime collectedAt;
  final DateTime createdAt;

  const CollectionResponseDto({
    required this.id,
    required this.routeId,
    required this.locationName,
    required this.temperature,
    required this.notes,
    required this.collectedAt,
    required this.createdAt,
  });

  factory CollectionResponseDto.fromMap(Map<String, dynamic> map) {
    return CollectionResponseDto(
      id: map['id'] as int,
      routeId: map['route'] as int,
      locationName: map['location_name'] as String,
      temperature: map['temperature'].toString(),
      notes: (map['notes'] ?? '') as String,
      collectedAt: DateTime.parse(map['collected_at'] as String),
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }
}