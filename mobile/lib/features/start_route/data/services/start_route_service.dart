import 'package:mobile/core/network/api_client.dart';
import 'package:mobile/features/start_route/data/dto/route_response_dto.dart';
import 'package:mobile/features/start_route/domain/models/route_draft.dart';

class StartRouteService {
  final ApiClient _apiClient;

  StartRouteService({ApiClient? apiClient})
      : _apiClient = apiClient ?? ApiClient();

  Future<RouteResponseDto> createRoute(RouteDraft draft) async {
    final response = await _apiClient.post(
      '/routes/',
      body: draft.toMap(),
    );

    return RouteResponseDto.fromMap(response);
  }
}