class ReceivingDraft {
  final int routeId;
  final String receiverName;
  final String temperature;
  final String integrityStatus;
  final String notes;
  final DateTime receivedAt;

  const ReceivingDraft({
    required this.routeId,
    required this.receiverName,
    required this.temperature,
    required this.integrityStatus,
    required this.notes,
    required this.receivedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'receiver_name': receiverName,
      'temperature': temperature,
      'integrity_status': integrityStatus,
      'notes': notes,
      'received_at': receivedAt.toIso8601String(),
    };
  }
}