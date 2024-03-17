import 'package:cv_frontend/features/account_setup/presentation/pages/country_screen.dart';
import 'package:cv_frontend/features/account_setup/presentation/pages/role_picking.dart';
import 'package:cv_frontend/features/authentication/presentation/pages/login_screen.dart';
import 'package:cv_frontend/features/authentication/presentation/pages/register_screen.dart';
import 'package:cv_frontend/features/home/presentation/home_screen.dart';
import 'package:flutter/material.dart';

const String loginScreen = '/login';
const String homeScreen = '/home';
const String registerScreen = '/register';
const String countryScreen = '/countryscreen';
const String pickrole = '/pickrole';
Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case homeScreen:
      return MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      );
    case loginScreen:
      return MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      );
    case registerScreen:
      return MaterialPageRoute(
        builder: (context) => const RegisterScreen(),
      );
    case countryScreen:
      return MaterialPageRoute(
        builder: (context) => const CountryScreen(),
      );
          case pickrole:
      return MaterialPageRoute(
        builder: (context) => const RolePick(),
      );

    default:
      throw ('this route name does not exist');
  }
}
