import 'dart:io';
import 'package:cv_frontend/core/constants/constants.dart';
import 'package:cv_frontend/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:cv_frontend/injection_container.dart';
import 'package:cv_frontend/core/services/app_routes.dart' as route;
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await initializeDependencies();
  await TokenManager.initialize();
  final initialRoute =  route.boardingScreen;   

  runApp(MyApp(initialRoute: initialRoute));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      designSize: const Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Job Finder',
        theme: theme(),
        onGenerateRoute: route.controller,
        initialRoute: initialRoute,
      ),
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
