import 'package:mobile/core/network/api_client.dart';
import 'package:mobile/features/auth/data/dto/login_response_dto.dart';

class AuthService {
  final ApiClient _apiClient;

  AuthService({ApiClient? apiClient}) : _apiClient = apiClient ?? ApiClient();

  Future<LoginResponseDto> login({
    required String username,
    required String password,
  }) async {
    final response = await _apiClient.post(
      '/auth/login/',
      body: {
        'username': username,
        'password': password,
      },
    );

    final loginResponse = LoginResponseDto.fromMap(response);
    ApiClient.accessToken = loginResponse.accessToken;

    return loginResponse;
  }

  void logout() {
    ApiClient.accessToken = null;
  }
}