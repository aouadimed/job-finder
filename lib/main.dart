import 'dart:io';

import 'package:cv_frontend/core/theme/app_theme.dart';
import 'package:cv_frontend/features/account_setup/presentation/pages/country_screen.dart';
import 'package:cv_frontend/features/onboarding/presentation/on_boarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:cv_frontend/injection_container.dart';
import 'package:cv_frontend/core/services/app_routes.dart' as route;

import 'features/authentication/presentation/pages/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: route.controller,
      // initialRoute: route.loginScreen,
      home: const CountryScreen(),
      theme: theme(),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
