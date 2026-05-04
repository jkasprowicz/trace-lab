import 'package:flutter/material.dart';
import 'package:mobile/features/admin/presentation/screens/admin_dashboard_screen.dart';
import 'package:mobile/features/auth/domain/models/auth_user.dart';
import 'package:mobile/features/driver/presentation/screens/driver_home_screen.dart';
import 'package:mobile/features/receiver/presentation/screens/receiver_home_screen.dart';

class RoleGateScreen extends StatelessWidget {
  final AuthUser user;

  const RoleGateScreen({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    switch (user.role) {
      case 'driver':
        return DriverHomeScreen(user: user);
      case 'receiver':
        return ReceiverHomeScreen(user: user);
      case 'admin':
        return AdminDashboardScreen(user: user);
      default:
        return const Scaffold(
          body: Center(
            child: Text('Unauthorized role'),
          ),
        );
    }
  }
}