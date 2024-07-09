import 'package:cv_frontend/core/services/app_routes.dart';
import 'package:cv_frontend/features/profil/presentation/bloc/education_bloc/education_bloc.dart';
import 'package:cv_frontend/features/profil/presentation/bloc/languages_bloc/language_bloc.dart';
import 'package:cv_frontend/features/profil/presentation/bloc/project_bloc/project_bloc.dart';
import 'package:cv_frontend/features/profil/presentation/bloc/summary_bloc/summary_bloc.dart';
import 'package:cv_frontend/features/profil/presentation/bloc/work_experience_bloc/work_experience_bloc.dart';
import 'package:cv_frontend/features/profil/presentation/pages/education_screen.dart';
import 'package:cv_frontend/features/profil/presentation/pages/languages_screen.dart';
import 'package:cv_frontend/features/profil/presentation/pages/project_screen.dart';
import 'package:cv_frontend/features/profil/presentation/pages/work_experience_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void goToSummaryScreen(BuildContext context) async {
  await Navigator.pushNamed(context, summaryScreen).then(
    (_) {
      if (context.mounted) {
        BlocProvider.of<SummaryBloc>(context).add(GetSummaryEvent());
      }
    },
  );
}

void goToWorkExperienceScreen(
    BuildContext context, bool isUpdate, String id) async {
  await Navigator.pushNamed(context, workExperienceScreen,
          arguments: WorkExperienceScreenArguments(isUpdate: isUpdate, id))
      .then(
    (_) {
      if (context.mounted) {
        BlocProvider.of<WorkExperienceBloc>(context)
            .add(GetAllWorkExperienceEvent());
      }
    },
  );
}

void goToEducationScreen(BuildContext context, bool isUpdate, String id) async {
  await Navigator.pushNamed(context, educationScreen,
          arguments: EducationScreenArguments(isUpdate: isUpdate, id))
      .then(
    (_) {
      if (context.mounted) {
        BlocProvider.of<EducationBloc>(context).add(GetAllEducationEvent());
      }
    },
  );
}

void goToProjectScreen(BuildContext context, bool isUpdate, String id) async {
  await Navigator.pushNamed(context, projectScreen,
          arguments: ProjectScreenArguments(isUpdate: isUpdate, id))
      .then(
    (_) {
      if (context.mounted) {
        BlocProvider.of<ProjectBloc>(context).add(GetAllProjectsEvent());
      }
    },
  );
}

void goToLanguageScreen(BuildContext context, bool isUpdate, String id) async {
  await Navigator.pushNamed(context, languagesScreen,
          arguments: LanguagesScreenArguments(isUpdate: isUpdate, id))
      .then(
    (_) {
      if (context.mounted) {
        BlocProvider.of<LanguageBloc>(context).add(GetAllLanguagesEvent());
      }
    },
  );
}

void goToSkillScreen(BuildContext context) async {
  await Navigator.pushNamed(
    context,
    skillsScreen,
  );
}




