import 'package:flutter/material.dart';
import 'package:mobile/features/auth/domain/models/auth_user.dart';

class AdminDashboardScreen extends StatelessWidget {
  final AuthUser user;

  const AdminDashboardScreen({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
      ),
      body: Center(
        child: Text('Admin: ${user.username}'),
      ),
    );
  }
}