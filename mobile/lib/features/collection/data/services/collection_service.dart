import 'package:mobile/core/network/api_client.dart';
import 'package:mobile/features/collection/data/dto/collection_response_dto.dart';
import 'package:mobile/features/collection/domain/models/collection_draft.dart';

class CollectionService {
  final ApiClient _apiClient;

  CollectionService({ApiClient? apiClient})
      : _apiClient = apiClient ?? ApiClient();

  Future<CollectionResponseDto> createCollection(CollectionDraft draft) async {
    final response = await _apiClient.post(
      '/routes/${draft.routeId}/collections/',
      body: draft.toMap(),
    );

    return CollectionResponseDto.fromMap(response);
  }

  Future<List<CollectionResponseDto>> fetchCollections(int routeId) async {
    final response = await _apiClient.getList('/routes/$routeId/collections/');

    return response
        .map((item) => CollectionResponseDto.fromMap(item))
        .toList();
  }
}