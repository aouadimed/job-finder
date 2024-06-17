import 'dart:io';

import 'package:cv_frontend/core/theme/app_theme.dart';
import 'package:cv_frontend/features/authentication/presentation/pages/register_screen.dart';
import 'package:cv_frontend/features/home/presentation/pages/home_screen.dart';
import 'package:cv_frontend/features/onboarding/presentation/on_boarding_screen.dart';
import 'package:cv_frontend/features/profil/presentation/pages/profil_screen.dart';
import 'package:flutter/material.dart';
import 'package:cv_frontend/injection_container.dart';
import 'package:cv_frontend/core/services/app_routes.dart' as route;

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
      home: const ProfilScreen(),
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
