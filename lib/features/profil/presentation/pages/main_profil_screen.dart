import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:cv_frontend/core/services/profil_screen_route.dart';
import 'package:cv_frontend/features/job_details_and_apply/presentation/bloc/job_apply_bloc/job_apply_bloc.dart';
import 'package:cv_frontend/features/job_details_and_apply/presentation/pages/widget/apply_with_profil.dart';
import 'package:cv_frontend/features/profil/data/models/contact_info_model.dart';
import 'package:cv_frontend/features/profil/data/models/education_model.dart';
import 'package:cv_frontend/features/profil/data/models/language_model.dart';
import 'package:cv_frontend/features/profil/data/models/profil_header_model.dart';
import 'package:cv_frontend/features/profil/data/models/project_model.dart';
import 'package:cv_frontend/features/profil/data/models/work_experience_model.dart';
import 'package:cv_frontend/features/profil/presentation/bloc/education_bloc/education_bloc.dart';
import 'package:cv_frontend/features/profil/presentation/bloc/languages_bloc/language_bloc.dart';
import 'package:cv_frontend/features/profil/presentation/bloc/project_bloc/project_bloc.dart';
import 'package:cv_frontend/features/profil/presentation/bloc/summary_bloc/summary_bloc.dart';
import 'package:cv_frontend/features/profil/presentation/bloc/work_experience_bloc/work_experience_bloc.dart';
import 'package:cv_frontend/features/profil/presentation/pages/widgets/profil_safe_area.dart';
import 'package:cv_frontend/features/profil/presentation/pages/widgets/utils/navigation_util.dart';
import 'package:cv_frontend/features/profil/presentation/pages/widgets/utils/profil_bloc_listeners.dart';
import 'package:cv_frontend/global/common_widget/pop_up_msg.dart';
import 'package:cv_frontend/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:cv_frontend/global/common_widget/app_bar.dart';
import 'package:cv_frontend/global/common_widget/loading_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilScreen extends StatefulWidget {
  final ProfilScreenArguments? arguments;

  const ProfilScreen({super.key, this.arguments});

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

  void setExpandedSection(String? section) {
    setState(() {
      expandedSection = section;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isApplyForJob = widget.arguments?.isApplyForJob ?? false;

    return ProfileBlocListeners(
      onContactInfoLoaded: (contactInfoModel) {
        setState(() {
          contactInfo = contactInfoModel;
        });
      },
      onProfilHeaderLoaded: (profilHeaderModel) {
        setState(() {
          profileHeader = profilHeaderModel;
        });
      },
      onSummaryLoaded: (description) {
        setState(() {
          summaryDescription = description;
        });
      },
      onWorkExperiencesLoaded: (workExperiencesModel) {
        setState(() {
          experiences = workExperiencesModel;
        });
      },
      onEducationsLoaded: (educationsModel) {
        setState(() {
          educations = educationsModel;
        });
      },
      onProjectsLoaded: (projectsModel) {
        setState(() {
          projects = projectsModel;
        });
      },
      onLanguagesLoaded: (languagesModel) {
        setState(() {
          languages = languagesModel;
        });
      },
      child: Scaffold(
        appBar: isApplyForJob
            ? const GeneralAppBar(
                titleText: "Apply Job",
              )
            : const GeneralAppBar(
                titleText: "Profile",
                logo: AssetImage('assets/images/logo.webp'),
                rightIcon: Icons.settings_outlined,
              ),
        body: SafeArea(
          child: BlocBuilder<SummaryBloc, SummaryState>(
            builder: (context, summaryState) {
              return BlocBuilder<WorkExperienceBloc, WorkExperienceState>(
                builder: (context, workExperienceState) {
                  return BlocBuilder<EducationBloc, EducationState>(
                    builder: (context, educationState) {
                      return BlocBuilder<ProjectBloc, ProjectState>(
                        builder: (context, projectState) {
                          return BlocBuilder<LanguageBloc, LanguageState>(
                            builder: (context, languageState) {
                              if (summaryState is SummaryLoading ||
                                  workExperienceState
                                      is WorkExperienceLoading ||
                                  educationState is EducationLoading ||
                                  projectState is ProjectLoading ||
                                  languageState is LanguageLoading) {
                                return const LoadingWidget();
                              } else {
                                return ProfileSafeArea(
                                  scrollController: _scrollController,
                                  profileHeader: profileHeader,
                                  contactInfo: contactInfo,
                                  summaryDescription: summaryDescription,
                                  experiences: experiences,
                                  educations: educations,
                                  projects: projects,
                                  languages: languages,
                                  expandedSection: expandedSection,
                                  educationKey: educationKey,
                                  workExperienceKey: workExperienceKey,
                                  languageKey: languageKey,
                                  projectKey: projectKey,
                                  summaryKey: summaryKey,
                                  contactInfoKey: contactInfoKey,
                                  setExpandedSection: setExpandedSection,
                                  goToSimpleProfilScreen:
                                      goToSimpleProfilScreen,
                                  goToContactInfoScreen: goToContactInfoScreen,
                                  goToSummaryScreen: goToSummaryScreen,
                                  goToWorkExperienceScreen:
                                      goToWorkExperienceScreen,
                                  goToEducationScreen: goToEducationScreen,
                                  goToProjectScreen: goToProjectScreen,
                                  goToLanguageScreen: goToLanguageScreen,
                                  goToSkillScreen: goToSkillScreen,
                                );
                              }
                            },
                          );
                        },
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
        bottomNavigationBar: isApplyForJob
            ? BlocProvider(
                create: (context) => sl<JobApplyBloc>(),
                child: BlocConsumer<JobApplyBloc, JobApplyState>(
                  listener: (context, state) {
                    if (state is JobApplyFailure) {
                      showSnackBar(context: context, message: state.message);
                    } else if (state is JobApplySuccess) {
                      showSnackBar(
                        context: context,
                        message: "Application submitted successfully!",
                        backgroundColor: greenColor,
                      );
                      Navigator.of(context)
                        ..pop()
                        ..pop()
                        ..pop();
                    }
                  },
                  builder: (context, state) {
                    if (state is JobApplyLoading) {
                      return const LoadingWidget();
                    } else if (state is JobApplySuccess) {
                      return const SizedBox();
                    }
                    return ApplyWithProfil(
                        jobOfferId: widget.arguments?.id ?? "");
                  },
                ),
              )
            : null,
      ),
    );
  }
}
