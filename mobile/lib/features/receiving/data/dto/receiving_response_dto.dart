class ReceivingResponseDto {
  final int id;
  final int routeId;
  final String receiverName;
  final String temperature;
  final String integrityStatus;
  final String notes;
  final DateTime receivedAt;
  final DateTime createdAt;

  const ReceivingResponseDto({
    required this.id,
    required this.routeId,
    required this.receiverName,
    required this.temperature,
    required this.integrityStatus,
    required this.notes,
    required this.receivedAt,
    required this.createdAt,
  });

  factory ReceivingResponseDto.fromMap(Map<String, dynamic> map) {
    return ReceivingResponseDto(
      id: map['id'] as int,
      routeId: map['route'] as int,
      receiverName: map['receiver_name'] as String,
      temperature: map['temperature'].toString(),
      integrityStatus: map['integrity_status'] as String,
      notes: (map['notes'] ?? '') as String,
      receivedAt: DateTime.parse(map['received_at'] as String),
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }
}