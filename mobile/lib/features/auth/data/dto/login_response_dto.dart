import 'package:mobile/features/auth/domain/models/auth_user.dart';

class LoginResponseDto {
  final String accessToken;
  final String refreshToken;
  final AuthUser user;

  const LoginResponseDto({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  factory LoginResponseDto.fromMap(Map<String, dynamic> map) {
    return LoginResponseDto(
      accessToken: map['access'] as String,
      refreshToken: map['refresh'] as String,
      user: AuthUser.fromMap(map['user'] as Map<String, dynamic>),
    );
  }
}