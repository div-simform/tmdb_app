import 'package:flutter/material.dart';
import 'package:tmdb_app/service/navigation_service.dart';
import 'package:tmdb_app/utils/app_nav_name.dart';
import 'package:tmdb_app/utils/app_string.dart';
import 'package:tmdb_app/utils/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppString.homeTitle,
      debugShowCheckedModeBanner: false,
      theme: AppTheme().appTheme,
      initialRoute: AppNavPath.splashPage,
      onGenerateRoute: NavigationService().generatedRoutes,
    );
  }
}
