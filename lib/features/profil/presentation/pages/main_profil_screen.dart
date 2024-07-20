import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:cv_frontend/features/profil/data/models/contact_info_model.dart';
import 'package:cv_frontend/features/profil/data/models/education_model.dart';
import 'package:cv_frontend/features/profil/data/models/language_model.dart';
import 'package:cv_frontend/features/profil/data/models/profil_header_model.dart';
import 'package:cv_frontend/features/profil/data/models/project_model.dart';
import 'package:cv_frontend/features/profil/data/models/work_experience_model.dart';
import 'package:cv_frontend/features/profil/presentation/bloc/contact_info_bloc/contact_info_bloc.dart';
import 'package:cv_frontend/features/profil/presentation/bloc/education_bloc/education_bloc.dart';
import 'package:cv_frontend/features/profil/presentation/bloc/languages_bloc/language_bloc.dart';
import 'package:cv_frontend/features/profil/presentation/bloc/profil_header_bloc/profil_header_bloc.dart';
import 'package:cv_frontend/features/profil/presentation/bloc/project_bloc/project_bloc.dart';
import 'package:cv_frontend/features/profil/presentation/bloc/summary_bloc/summary_bloc.dart';
import 'package:cv_frontend/features/profil/presentation/bloc/work_experience_bloc/work_experience_bloc.dart';
import 'package:cv_frontend/features/profil/presentation/pages/widgets/profil_expanded_cards/profil_header.dart';
import 'package:cv_frontend/features/profil/presentation/pages/widgets/utils/navigation.dart';
import 'package:cv_frontend/features/profil/presentation/pages/widgets/profil_expanded_cards/common_card.dart';
import 'package:cv_frontend/features/profil/presentation/pages/widgets/profil_expanded_cards/contact_inforamtion_card.dart';
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
  ContactInfoModel contactInfo = ContactInfoModel();
  ProfilHeaderModel profileHeader = ProfilHeaderModel();

  String? expandedSection;
  GlobalKey educationKey = GlobalKey();
  GlobalKey workExperienceKey = GlobalKey();
  GlobalKey languageKey = GlobalKey();
  GlobalKey projectKey = GlobalKey();
  GlobalKey summaryKey = GlobalKey();
  GlobalKey contactInfoKey = GlobalKey();

  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ProfilHeaderBloc, ProfilHeaderState>(
            listener: (context, state) {
          if (state is GetProfilHeaderSuccess) {
            setState(() {
              profileHeader = state.profileHeader;
            });
          }
        }),
        BlocListener<ContactInfoBloc, ContactInfoState>(
            listener: (context, state) {
          if (state is GetContactInfoSuccess) {
            setState(() {
              contactInfo = state.contactInfoModel;
            });
          }
        }),
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
          logo: AssetImage('assets/images/logo.webp'),
          rightIcon: Icons.settings_outlined,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                MainProfileHeader(
                  profileHeader: profileHeader,
                  onEdit: () {
                    goToSimpleProfilScreen(context);
                  },
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
                      ContactInformationCard(
                        iconOnPressed: () {
                          goToContactInfoScreen(context);
                        },
                        isExpanded: expandedSection == 'contactInfo',
                        onExpansionChanged: (bool value) {
                          setState(() {
                            expandedSection = value ? 'contactInfo' : null;
                          });
                          if (value) _scrollToSection(contactInfoKey);
                        },
                        sectionKey: contactInfoKey,
                        contactInfo: contactInfo,
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
                            return SummaryCard(
                              iconOnPressed: () {
                                goToSummaryScreen(context);
                              },
                              summaryDescription: summaryDescription,
                              isExpanded: expandedSection == 'summary',
                              onExpansionChanged: (bool value) {
                                setState(() {
                                  expandedSection = value ? 'summary' : null;
                                });
                                if (value) _scrollToSection(summaryKey);
                              },
                              sectionKey: summaryKey,
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
                              isExpanded: expandedSection == 'work_experience',
                              onExpansionChanged: (bool value) {
                                setState(() {
                                  expandedSection =
                                      value ? 'work_experience' : null;
                                });
                                if (value) _scrollToSection(workExperienceKey);
                              },
                              sectionKey: workExperienceKey,
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
                              isExpanded: expandedSection == 'education',
                              onExpansionChanged: (bool value) {
                                setState(() {
                                  expandedSection = value ? 'education' : null;
                                });
                                if (value) _scrollToSection(educationKey);
                              },
                              sectionKey: educationKey,
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
                              isExpanded: expandedSection == 'projects',
                              onExpansionChanged: (bool value) {
                                setState(() {
                                  expandedSection = value ? 'projects' : null;
                                });
                                if (value) _scrollToSection(projectKey);
                              },
                              sectionKey: projectKey,
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
                                  isExpanded: expandedSection == 'languages',
                                  onExpansionChanged: (bool value) {
                                    setState(() {
                                      expandedSection =
                                          value ? 'languages' : null;
                                    });
                                    if (value) _scrollToSection(languageKey);
                                  },
                                  sectionKey: languageKey,
                                ),
                                const SizedBox(height: 20),
                                CommonCard(
                                  onCardPressed: () {
                                    goToSkillScreen(context);
                                  },
                                  headerTitle: "Skills",
                                  headerIcon: Icons.pie_chart_sharp,
                                ),
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

  void _scrollToSection(GlobalKey key) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final renderObject = key.currentContext?.findRenderObject();
      if (renderObject is RenderBox) {
        final RenderBox box = renderObject;
        final Offset position = box.localToGlobal(Offset.zero);
        final double offset = position.dy;
        final double screenHeight = MediaQuery.of(context).size.height;
        final double itemHeight = box.size.height;

        if (offset + itemHeight > screenHeight) {
          _scrollController.animateTo(
            _scrollController.offset +
                (offset + itemHeight - screenHeight + 16),
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        } else {
          _scrollController.animateTo(
            _scrollController.offset + offset - 100,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      }
    });
  }
}
