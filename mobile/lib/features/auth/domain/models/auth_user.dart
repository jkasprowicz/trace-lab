class AuthUser {
  final int id;
  final String username;
  final String email;
  final String role;

  const AuthUser({
    required this.id,
    required this.username,
    required this.email,
    required this.role,
  });

  factory AuthUser.fromMap(Map<String, dynamic> map) {
    return AuthUser(
      id: map['id'] as int,
      username: map['username'] as String,
      email: (map['email'] ?? '') as String,
      role: map['role'] as String,
    );
  }
}