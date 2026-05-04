import 'package:flutter/material.dart';
import 'package:mobile/app/routes.dart';
import 'package:mobile/core/theme/app_theme.dart';
import 'package:mobile/features/home/presentation/screens/home_screen.dart';
import 'package:mobile/features/start_route/presentation/screens/start_route_screen.dart';
import 'package:mobile/features/active_route/presentation/screens/active_route_screen.dart';
import 'package:mobile/features/collection/presentation/screens/add_collection_screen.dart';
import 'package:mobile/features/route_summary/presentation/screens/route_summary_screen.dart';
import 'package:mobile/features/receiving/presentation/screens/receiving_screen.dart';
import 'package:mobile/features/auth/presentation/screens/login_screen.dart';

class TraceLabApp extends StatelessWidget {
  const TraceLabApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TraceLab',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.login,
      routes: {
        AppRoutes.login: (_) => const LoginScreen(),
        AppRoutes.home: (_) => const HomeScreen(),
        AppRoutes.startRoute: (_) => const StartRouteScreen(),
        AppRoutes.activeRoute: (_) => const ActiveRouteScreen(),
        AppRoutes.addCollection: (_) => const AddCollectionScreen(),
        AppRoutes.routeSummary: (_) => const RouteSummaryScreen(),
        AppRoutes.receiving: (_) => const ReceivingScreen(),
      },
    );
  }
}