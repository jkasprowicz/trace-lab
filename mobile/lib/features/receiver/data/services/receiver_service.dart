import 'package:mobile/core/network/api_client.dart';
import 'package:mobile/features/start_route/data/dto/route_response_dto.dart';

class ReceiverService {
  final ApiClient _apiClient;

  ReceiverService({ApiClient? apiClient})
      : _apiClient = apiClient ?? ApiClient();

  Future<List<RouteResponseDto>> fetchPendingReceivingRoutes() async {
    final response = await _apiClient.getList('/routes/pending-receiving/');

    return response
        .map((item) => RouteResponseDto.fromMap(item))
        .toList();
  }
}