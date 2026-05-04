import 'package:mobile/core/network/api_client.dart';
import 'package:mobile/features/receiving/data/dto/receiving_response_dto.dart';
import 'package:mobile/features/receiving/domain/models/receiving_draft.dart';

class ReceivingService {
  final ApiClient _apiClient;

  ReceivingService({ApiClient? apiClient})
      : _apiClient = apiClient ?? ApiClient();

  Future<ReceivingResponseDto> createReceiving(ReceivingDraft draft) async {
    final response = await _apiClient.post(
      '/routes/${draft.routeId}/receiving/',
      body: draft.toMap(),
    );

    return ReceivingResponseDto.fromMap(response);
  }
}