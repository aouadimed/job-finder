import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cv_frontend/features/profil/presentation/bloc/contact_info_bloc/contact_info_bloc.dart';
import 'package:cv_frontend/features/profil/presentation/bloc/education_bloc/education_bloc.dart';
import 'package:cv_frontend/features/profil/presentation/bloc/languages_bloc/language_bloc.dart';
import 'package:cv_frontend/features/profil/presentation/bloc/profil_header_bloc/profil_header_bloc.dart';
import 'package:cv_frontend/features/profil/presentation/bloc/project_bloc/project_bloc.dart';
import 'package:cv_frontend/features/profil/presentation/bloc/summary_bloc/summary_bloc.dart';
import 'package:cv_frontend/features/profil/presentation/bloc/work_experience_bloc/work_experience_bloc.dart';
import 'package:flutter/material.dart';

import 'package:cv_frontend/features/profil/data/models/contact_info_model.dart';
import 'package:cv_frontend/features/profil/data/models/education_model.dart';
import 'package:cv_frontend/features/profil/data/models/language_model.dart';
import 'package:cv_frontend/features/profil/data/models/profil_header_model.dart';
import 'package:cv_frontend/features/profil/data/models/project_model.dart';
import 'package:cv_frontend/features/profil/data/models/work_experience_model.dart';

class ProfileBlocListeners extends StatelessWidget {
  final Widget child;
  final Function(ContactInfoModel) onContactInfoLoaded;
  final Function(ProfilHeaderModel) onProfilHeaderLoaded;
  final Function(String) onSummaryLoaded;
  final Function(List<WorkExperiencesModel>) onWorkExperiencesLoaded;
  final Function(List<EducationsModel>) onEducationsLoaded;
  final Function(List<ProjectsModel>) onProjectsLoaded;
  final Function(List<LanguageModel>) onLanguagesLoaded;

  const ProfileBlocListeners({
    Key? key,
    required this.child,
    required this.onContactInfoLoaded,
    required this.onProfilHeaderLoaded,
    required this.onSummaryLoaded,
    required this.onWorkExperiencesLoaded,
    required this.onEducationsLoaded,
    required this.onProjectsLoaded,
    required this.onLanguagesLoaded,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ProfilHeaderBloc, ProfilHeaderState>(
          listener: (context, state) {
            if (state is GetProfilHeaderSuccess) {
              onProfilHeaderLoaded(state.profileHeader);
            }
          },
        ),
        BlocListener<ContactInfoBloc, ContactInfoState>(
          listener: (context, state) {
            if (state is GetContactInfoSuccess) {
              onContactInfoLoaded(state.contactInfoModel);
            }
          },
        ),
        BlocListener<SummaryBloc, SummaryState>(
          listener: (context, state) {
            if (state is GetSummarySuccess) {
              onSummaryLoaded(state.summaryModel.description ?? '');
            }
          },
        ),
        BlocListener<WorkExperienceBloc, WorkExperienceState>(
          listener: (context, state) {
            if (state is GetAllWorkExperienceSuccess) {
              onWorkExperiencesLoaded(state.workExperiencesModel);
            }
          },
        ),
        BlocListener<EducationBloc, EducationState>(
          listener: (context, state) {
            if (state is GetAllEducationSuccess) {
              onEducationsLoaded(state.educationsModel);
            }
          },
        ),
        BlocListener<ProjectBloc, ProjectState>(
          listener: (context, state) {
            if (state is GetAllProjectsSuccess) {
              onProjectsLoaded(state.projects);
            }
          },
        ),
        BlocListener<LanguageBloc, LanguageState>(
          listener: (context, state) {
            if (state is GetAllLanguagesSuccess) {
              onLanguagesLoaded(state.languages);
            }
          },
        ),
      ],
      child: child,
    );
  }
}
