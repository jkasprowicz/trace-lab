import 'package:mobile/core/network/api_client.dart';
import 'package:mobile/features/start_route/data/dto/route_response_dto.dart';

class ActiveRouteService {
  final ApiClient _apiClient;

  ActiveRouteService({ApiClient? apiClient})
      : _apiClient = apiClient ?? ApiClient();

  Future<RouteResponseDto> finishRoute(int routeId) async {
    final response = await _apiClient.post(
      '/routes/$routeId/finish/',
      body: const {},
    );

    return RouteResponseDto.fromMap(response);
  }
}