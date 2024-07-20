import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cv_frontend/features/profil/presentation/pages/main_profil_screen.dart';
import 'package:cv_frontend/features/profil/presentation/bloc/contact_info_bloc/contact_info_bloc.dart';
import 'package:cv_frontend/features/profil/presentation/bloc/education_bloc/education_bloc.dart';
import 'package:cv_frontend/features/profil/presentation/bloc/languages_bloc/language_bloc.dart';
import 'package:cv_frontend/features/profil/presentation/bloc/profil_header_bloc/profil_header_bloc.dart';
import 'package:cv_frontend/features/profil/presentation/bloc/project_bloc/project_bloc.dart';
import 'package:cv_frontend/features/profil/presentation/bloc/summary_bloc/summary_bloc.dart';
import 'package:cv_frontend/features/profil/presentation/bloc/work_experience_bloc/work_experience_bloc.dart';
import 'package:cv_frontend/injection_container.dart';

MultiBlocProvider profilScreenProvider() {
  return MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => sl<ProfilHeaderBloc>()..add(GetProfilHeaderEvent()),
      ),
      BlocProvider(
        create: (context) => sl<ContactInfoBloc>()..add(GetContactInfoEvent()),
      ),
      BlocProvider(
        create: (context) => sl<SummaryBloc>()..add(GetSummaryEvent()),
      ),
      BlocProvider(
        create: (context) => sl<WorkExperienceBloc>()..add(GetAllWorkExperienceEvent()),
      ),
      BlocProvider(
        create: (context) => sl<EducationBloc>()..add(GetAllEducationEvent()),
      ),
      BlocProvider(
        create: (context) => sl<ProjectBloc>()..add(GetAllProjectsEvent()),
      ),
      BlocProvider(
        create: (context) => sl<LanguageBloc>()..add(GetAllLanguagesEvent()),
      ),
    ],
    child: const ProfilScreen(),
  );
}
