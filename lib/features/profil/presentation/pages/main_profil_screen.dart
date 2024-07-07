import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:cv_frontend/features/profil/data/models/education_model.dart';
import 'package:cv_frontend/features/profil/data/models/language_model.dart';
import 'package:cv_frontend/features/profil/data/models/project_model.dart';
import 'package:cv_frontend/features/profil/data/models/work_experience_model.dart';
import 'package:cv_frontend/features/profil/presentation/bloc/education_bloc/education_bloc.dart';
import 'package:cv_frontend/features/profil/presentation/bloc/languages_bloc/language_bloc.dart';
import 'package:cv_frontend/features/profil/presentation/bloc/project_bloc/project_bloc.dart';
import 'package:cv_frontend/features/profil/presentation/bloc/summary_bloc/summary_bloc.dart';
import 'package:cv_frontend/features/profil/presentation/bloc/work_experience_bloc/work_experience_bloc.dart';
import 'package:cv_frontend/features/profil/presentation/pages/utils/navigation.dart';
import 'package:cv_frontend/features/profil/presentation/pages/widgets/profil_expanded_cards/common_card.dart';
import 'package:cv_frontend/features/profil/presentation/pages/widgets/profil_expanded_cards/education_card.dart';
import 'package:cv_frontend/features/profil/presentation/pages/widgets/profil_expanded_cards/language_card.dart';
import 'package:cv_frontend/features/profil/presentation/pages/widgets/profil_expanded_cards/projects_card.dart';
import 'package:cv_frontend/features/profil/presentation/pages/widgets/profil_expanded_cards/summary_card.dart';
import 'package:cv_frontend/features/profil/presentation/pages/widgets/profil_expanded_cards/work_experience_card.dart';
import 'package:cv_frontend/global/common_widget/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({super.key});

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  String summaryDescription = '';
  List<WorkExperiencesModel> experiences = [];
  List<EducationsModel> educations = [];
  List<ProjectsModel> projects = [];
  List<LanguageModel> languages = [];

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<SummaryBloc, SummaryState>(listener: (context, state) {
          if (state is GetSummarySuccess) {
            setState(() {
              summaryDescription = state.summaryModel.description ?? '';
            });
          }
        }),
        BlocListener<WorkExperienceBloc, WorkExperienceState>(
            listener: (context, state) {
          if (state is GetAllWorkExperienceSuccess) {
            setState(() {
              experiences = state.workExperiencesModel;
            });
          }
        }),
        BlocListener<EducationBloc, EducationState>(listener: (context, state) {
          if (state is GetAllEducationSuccess) {
            setState(() {
              educations = state.educationsModel;
            });
          }
        }),
        BlocListener<ProjectBloc, ProjectState>(listener: (context, state) {
          if (state is GetAllProjectsSuccess) {
            setState(() {
              projects = state.projects;
            });
          }
        }),
        BlocListener<LanguageBloc, LanguageState>(listener: (context, state) {
          if (state is GetAllLanguagesSuccess) {
            setState(() {
              languages = state.languages;
            });
          }
        })
      ],
      child: Scaffold(
        appBar: const GeneralAppBar(
          titleText: "Profile",
          logo: AssetImage(
            'assets/images/logo.webp',
          ),
          rightIcon: Icons.settings_outlined,
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 35,
                        backgroundImage: NetworkImage(
                            'http://192.168.1.12:5000/userimg/1717428491056-446084121.jpg'),
                      ),
                      const SizedBox(width: 16),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Mohamed Aouadi',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              'UI/UX Designer at Paypal Inc.',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.edit, color: primaryColor),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Divider(
                    thickness: 0.5,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Summary(
                        iconOnPressed: () {
                          goToSummaryScreen(context);
                        },
                        summaryDescription: summaryDescription,
                      ),
                      const SizedBox(height: 20),
                      BlocBuilder<SummaryBloc, SummaryState>(
                        builder: (context, state) {
                          if (state is SummaryLoading) {
                            return Center(
                              child: CircularProgressIndicator(
                                  color: primaryColor),
                            );
                          } else {
                            return Summary(
                              iconOnPressed: () {
                                goToSummaryScreen(context);
                              },
                              summaryDescription: summaryDescription,
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      BlocBuilder<WorkExperienceBloc, WorkExperienceState>(
                        builder: (context, state) {
                          if (state is WorkExperienceLoading) {
                            return Center(
                              child: CircularProgressIndicator(
                                  color: primaryColor),
                            );
                          } else {
                            return WorkExperienceWidget(
                              onAddPressed: () {
                                goToWorkExperienceScreen(context, false, "");
                              },
                              experiences: experiences,
                              onEditPressed: (String value) {
                                goToWorkExperienceScreen(context, true, value);
                              },
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      BlocBuilder<EducationBloc, EducationState>(
                        builder: (context, state) {
                          if (state is EducationLoading) {
                            return Center(
                              child: CircularProgressIndicator(
                                  color: primaryColor),
                            );
                          } else {
                            return EducationWidget(
                              education: educations,
                              onAddPressed: () {
                                goToEducationScreen(context, false, "");
                              },
                              onEditPressed: (String value) {
                                goToEducationScreen(context, true, value);
                              },
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      BlocBuilder<ProjectBloc, ProjectState>(
                        builder: (context, state) {
                          if (state is ProjectLoading) {
                            return Center(
                              child: CircularProgressIndicator(
                                  color: primaryColor),
                            );
                          } else {
                            return ProjectCard(
                              onAddPressed: () {
                                goToProjectScreen(context, false, "");
                              },
                              project: projects,
                              onEditPressed: (String value) {
                                goToProjectScreen(context, true, value);
                              },
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      BlocBuilder<LanguageBloc, LanguageState>(
                        builder: (context, state) {
                          if (state is LanguageLoading) {
                            return Center(
                              child: CircularProgressIndicator(
                                  color: primaryColor),
                            );
                          } else {
                            return Column(
                              children: [
                                LanguageCard(
                                  onAddPressed: () {
                                    goToLanguageScreen(context, false, "");
                                  },
                                  language: languages,
                                  onEditPressed: (String value) {
                                    goToLanguageScreen(context, true, value);
                                  },
                                ),
                                const SizedBox(height: 20),
                                CommonCard(
                                    onCardPressed: () {
                                      goToSkillScreen(context);
                                    },
                                    headerTitle: "Skills",
                                    headerIcon: Icons.pie_chart_sharp)
                              ],
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
