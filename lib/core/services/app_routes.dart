import 'package:cv_frontend/features/authentication/presentation/pages/account_setup/pages/country_screen.dart';
import 'package:cv_frontend/features/authentication/presentation/pages/account_setup/pages/profile_finish.dart';
import 'package:cv_frontend/features/authentication/presentation/pages/account_setup/pages/role_picking.dart';
import 'package:cv_frontend/features/authentication/presentation/pages/account_setup/pages/expertise_picking.dart';
import 'package:cv_frontend/features/authentication/presentation/pages/login_screen.dart';
import 'package:cv_frontend/features/authentication/presentation/pages/register_screen.dart';
import 'package:cv_frontend/features/home/presentation/pages/home_screen.dart';
import 'package:cv_frontend/features/onboarding/presentation/on_boarding_screen.dart';
import 'package:cv_frontend/features/profil/presentation/bloc/education_bloc/education_bloc.dart';
import 'package:cv_frontend/features/profil/presentation/bloc/languages_bloc/language_bloc.dart';
import 'package:cv_frontend/features/profil/presentation/bloc/project_bloc/project_bloc.dart';
import 'package:cv_frontend/features/profil/presentation/bloc/summary_bloc/summary_bloc.dart';
import 'package:cv_frontend/features/profil/presentation/bloc/work_experience_bloc/work_experience_bloc.dart';
import 'package:cv_frontend/features/profil/presentation/pages/education_screen.dart';
import 'package:cv_frontend/features/profil/presentation/pages/languages_screen.dart';
import 'package:cv_frontend/features/profil/presentation/pages/main_profil_screen.dart';
import 'package:cv_frontend/features/profil/presentation/pages/project_screen.dart';
import 'package:cv_frontend/features/profil/presentation/pages/summary_screen.dart';
import 'package:cv_frontend/features/profil/presentation/pages/work_experience_screen.dart';
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
const String profilScreen = '/profilScreen';
const String summaryScreen = '/summaryScreen';
const String workExperienceScreen = '/workExperienceScreen';
const String educationScreen = '/educationScreen';
const String projectScreen = '/projectScreen';
const String languagesScreen = '/languagesScreen';

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
    case profilScreen:
      return MaterialPageRoute(
        builder: (context) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => sl<SummaryBloc>()..add(GetSummaryEvent()),
            ),
            BlocProvider(
              create: (context) =>
                  sl<WorkExperienceBloc>()..add(GetAllWorkExperienceEvent()),
            ),
            BlocProvider(
              create: (context) =>
                  sl<EducationBloc>()..add(GetAllEducationEvent()),
            ),
            BlocProvider(
              create: (context) =>
                  sl<ProjectBloc>()..add(GetAllProjectsEvent()),
            ),
            BlocProvider(
              create: (context) =>
                  sl<LanguageBloc>()..add(GetAllLanguagesEvent()),
            )
          ],
          child: const ProfilScreen(),
        ),
      );
    case summaryScreen:
      return MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => sl<SummaryBloc>(),
          child: const SummaryScreen(),
        ),
      );
    case projectScreen:
      final args = settings.arguments as ProjectScreenArguments?;
      return MaterialPageRoute(
        builder: (context) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) {
                final bloc = sl<ProjectBloc>();
                if (args != null && args.id.isNotEmpty) {
                  bloc.add(GetSingleProjectEvent(id: args.id));
                }
                return bloc;
              },
            ),
            BlocProvider(
              create: (context) =>
                  sl<WorkExperienceBloc>()..add(GetAllWorkExperienceEvent()),
            ),
          ],
          child: ProjectScreen(
            isUpdate: args?.isUpdate ?? false,
            id: args?.id,
          ),
        ),
      );
    case languagesScreen:
      final args = settings.arguments as LanguagesScreenArguments?;
      return MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) {
            final bloc = sl<LanguageBloc>();
            if (args?.id != null) {
              bloc.add(GetSingleLanguageEvent(id: args!.id));
            }
            return bloc;
          },
          child: LanguagesScreen(
            isUpdate: args?.isUpdate ?? false,
            id: args?.id,
          ),
        ),
      );

    case educationScreen:
      final args = settings.arguments as EducationScreenArguments?;
      return MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) {
            final bloc = sl<EducationBloc>();
            if (args?.id != null) {
              bloc.add(GetSingleEducationEvent(id: args!.id));
            }
            return bloc;
          },
          child: EducationScreen(
            isUpdate: args?.isUpdate ?? false,
            id: args?.id,
          ),
        ),
      );
    case workExperienceScreen:
      final args = settings.arguments as WorkExperienceScreenArguments?;
      return MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) {
            final bloc = sl<WorkExperienceBloc>();
            if (args?.id != null) {
              bloc.add(GetSingleWorkExperienceEvent(id: args!.id));
            }
            return bloc;
          },
          child: WorkExperienceScreen(
            isUpdate: args?.isUpdate ?? false,
            id: args?.id,
          ),
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
      return MaterialPageRoute(
        builder: (context) => Scaffold(
          body: Center(
            child: Text('Route not found: ${settings.name}'),
          ),
        ),
      );
  }
}
