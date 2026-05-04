import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile/core/config/app_config.dart';

class ApiClient {
  static String? accessToken;

  final http.Client _httpClient;

  ApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  Map<String, String> get _headers {
    return {
      'Content-Type': 'application/json',
      if (accessToken != null) 'Authorization': 'Bearer $accessToken',
    };
  }

  Future<Map<String, dynamic>> post(
    String path, {
    required Map<String, dynamic> body,
  }) async {
    final uri = Uri.parse('${AppConfig.baseUrl}$path');

    final response = await _httpClient.post(
      uri,
      headers: _headers,
      body: jsonEncode(body),
    );

    final dynamic decodedBody = response.body.isNotEmpty
        ? jsonDecode(response.body)
        : <String, dynamic>{};

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('API error ${response.statusCode}: $decodedBody');
    }

    return Map<String, dynamic>.from(decodedBody as Map);
  }

  Future<Map<String, dynamic>> get(String path) async {
    final uri = Uri.parse('${AppConfig.baseUrl}$path');

    final response = await _httpClient.get(
      uri,
      headers: _headers,
    );

    final dynamic decodedBody = response.body.isNotEmpty
        ? jsonDecode(response.body)
        : <String, dynamic>{};

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('API error ${response.statusCode}: $decodedBody');
    }

    return Map<String, dynamic>.from(decodedBody as Map);
  }

  Future<List<Map<String, dynamic>>> getList(String path) async {
    final uri = Uri.parse('${AppConfig.baseUrl}$path');

    final response = await _httpClient.get(
      uri,
      headers: _headers,
    );

    final dynamic decodedBody =
        response.body.isNotEmpty ? jsonDecode(response.body) : <dynamic>[];

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('API error ${response.statusCode}: $decodedBody');
    }

    return List<Map<String, dynamic>>.from(decodedBody as List);
  }
}