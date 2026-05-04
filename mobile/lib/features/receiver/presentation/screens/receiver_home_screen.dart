import 'package:flutter/material.dart';
import 'package:mobile/features/auth/domain/models/auth_user.dart';

class ReceiverHomeScreen extends StatelessWidget {
  final AuthUser user;

  const ReceiverHomeScreen({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Receiving Dashboard'),
      ),
      body: Center(
        child: Text('Receiver: ${user.username}'),
      ),
    );
  }
}