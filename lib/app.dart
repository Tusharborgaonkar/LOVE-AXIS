import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'core/routes/app_routes.dart';
import 'core/routes/route_names.dart';

class LoveAxisApp extends StatelessWidget {
  const LoveAxisApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LoveAxis',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      // Force light theme only
      themeMode: ThemeMode.light,
      initialRoute: RouteNames.splash,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
