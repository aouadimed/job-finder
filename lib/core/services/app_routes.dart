import 'package:cv_frontend/features/authentication/presentation/pages/account_setup/pages/country_screen.dart';
import 'package:cv_frontend/features/authentication/presentation/pages/account_setup/pages/profile_finish.dart';
import 'package:cv_frontend/features/authentication/presentation/pages/account_setup/pages/role_picking.dart';
import 'package:cv_frontend/features/authentication/presentation/pages/account_setup/pages/expertise_picking.dart';
import 'package:cv_frontend/features/authentication/presentation/pages/login_screen.dart';
import 'package:cv_frontend/features/authentication/presentation/pages/register_screen.dart';
import 'package:cv_frontend/features/home/presentation/pages/home_screen.dart';
import 'package:cv_frontend/features/onboarding/presentation/on_boarding_screen.dart';
import 'package:cv_frontend/features/profil/presentation/bloc/summary_bloc.dart';
import 'package:cv_frontend/features/profil/presentation/pages/profil_screen.dart';
import 'package:cv_frontend/features/profil/presentation/pages/summary_screen.dart';
import 'package:cv_frontend/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const String boardingScreen = '/boarding';
const String loginScreen = '/login';
const String homeScreen = '/home';
const String registerScreen = '/register';
const String countryScreen = '/countryscreen';
const String pickrole = '/pickrole';
const String pickexpertive = '/pickexpertive';
const String finishprofil = '/finishprofil';
const String profil = '/profil';
const String summaryScreen = '/summaryScreen';

Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case boardingScreen:
      return MaterialPageRoute(
        builder: (context) => const OnBoardingScreen(),
      );
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
    case profil:
      return MaterialPageRoute(
        builder: (context) => const ProfilScreen(),
      );
    case summaryScreen:
      return MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => sl<SummaryBloc>(),
          child: const SummaryScreen(),
        ),
      );
    case countryScreen:
      return MaterialPageRoute(
          builder: (context) => const CountryScreen(), settings: settings);
    case pickrole:
      return MaterialPageRoute(
          builder: (context) => const RolePick(), settings: settings);
    case pickexpertive:
      return MaterialPageRoute(
          builder: (context) => const ExpertisePick(), settings: settings);
    case finishprofil:
      return MaterialPageRoute(
          builder: (context) => const FinishProfil(), settings: settings);

    default:
      throw ('this route name does not exist');
  }
}
