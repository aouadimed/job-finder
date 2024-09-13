// profile_safe_area.dart
import 'package:cv_frontend/global/common_widget/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:cv_frontend/features/profil/presentation/pages/widgets/profil_expanded_cards/profil_header.dart';
import 'package:cv_frontend/features/profil/presentation/pages/widgets/profil_expanded_cards/common_card.dart';
import 'package:cv_frontend/features/profil/presentation/pages/widgets/profil_expanded_cards/contact_inforamtion_card.dart';
import 'package:cv_frontend/features/profil/presentation/pages/widgets/profil_expanded_cards/education_card.dart';
import 'package:cv_frontend/features/profil/presentation/pages/widgets/profil_expanded_cards/language_card.dart';
import 'package:cv_frontend/features/profil/presentation/pages/widgets/profil_expanded_cards/projects_card.dart';
import 'package:cv_frontend/features/profil/presentation/pages/widgets/profil_expanded_cards/summary_card.dart';
import 'package:cv_frontend/features/profil/presentation/pages/widgets/profil_expanded_cards/work_experience_card.dart';
import 'package:cv_frontend/features/profil/presentation/pages/widgets/utils/scroll_util.dart';
import 'package:cv_frontend/features/profil/data/models/contact_info_model.dart';
import 'package:cv_frontend/features/profil/data/models/education_model.dart';
import 'package:cv_frontend/features/profil/data/models/language_model.dart';
import 'package:cv_frontend/features/profil/data/models/profil_header_model.dart';
import 'package:cv_frontend/features/profil/data/models/project_model.dart';
import 'package:cv_frontend/features/profil/data/models/work_experience_model.dart';

class ProfileSafeArea extends StatelessWidget {
  final ScrollController scrollController;
  final ProfilHeaderModel profileHeader;
  final ContactInfoModel contactInfo;
  final String summaryDescription;
  final List<WorkExperiencesModel> experiences;
  final List<EducationsModel> educations;
  final List<ProjectsModel> projects;
  final List<LanguageModel> languages;
  final String? expandedSection;
  final GlobalKey educationKey;
  final GlobalKey workExperienceKey;
  final GlobalKey languageKey;
  final GlobalKey projectKey;
  final GlobalKey summaryKey;
  final GlobalKey contactInfoKey;
  final bool isLoading;
  final Function(String? section) setExpandedSection;
  final Function(BuildContext context) goToSimpleProfilScreen;
  final Function(BuildContext context) goToContactInfoScreen;
  final Function(BuildContext context) goToSummaryScreen;
  final Function(BuildContext context, bool isEdit, String value)
      goToWorkExperienceScreen;
  final Function(BuildContext context, bool isEdit, String value)
      goToEducationScreen;
  final Function(BuildContext context, bool isEdit, String value)
      goToProjectScreen;
  final Function(BuildContext context, bool isEdit, String value)
      goToLanguageScreen;
  final Function(BuildContext context) goToSkillScreen;

  const ProfileSafeArea({
    Key? key,
    required this.scrollController,
    required this.profileHeader,
    required this.contactInfo,
    required this.summaryDescription,
    required this.experiences,
    required this.educations,
    required this.projects,
    required this.languages,
    required this.expandedSection,
    required this.educationKey,
    required this.workExperienceKey,
    required this.languageKey,
    required this.projectKey,
    required this.summaryKey,
    required this.contactInfoKey,
    required this.setExpandedSection,
    required this.goToSimpleProfilScreen,
    required this.goToContactInfoScreen,
    required this.goToSummaryScreen,
    required this.goToWorkExperienceScreen,
    required this.goToEducationScreen,
    required this.goToProjectScreen,
    required this.goToLanguageScreen,
    required this.goToSkillScreen,
    required this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (isLoading == true)
        ? LoadingWidget()
        : SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                MainProfileHeader(
                  profileHeader: profileHeader,
                  onEdit: () => goToSimpleProfilScreen(context),
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
                        iconOnPressed: () => goToContactInfoScreen(context),
                        isExpanded: expandedSection == 'contactInfo',
                        onExpansionChanged: (bool value) {
                          setExpandedSection(value ? 'contactInfo' : null);
                          if (value) {
                            scrollToSection(
                                context, scrollController, contactInfoKey);
                          }
                        },
                        sectionKey: contactInfoKey,
                        contactInfo: contactInfo,
                      ),
                      const SizedBox(height: 20),
                      SummaryCard(
                        iconOnPressed: () => goToSummaryScreen(context),
                        summaryDescription: summaryDescription,
                        isExpanded: expandedSection == 'summary',
                        onExpansionChanged: (bool value) {
                          setExpandedSection(value ? 'summary' : null);
                          if (value) {
                            scrollToSection(
                                context, scrollController, summaryKey);
                          }
                        },
                        sectionKey: summaryKey,
                      ),
                      const SizedBox(height: 20),
                      WorkExperienceWidget(
                        onAddPressed: () =>
                            goToWorkExperienceScreen(context, false, ""),
                        experiences: experiences,
                        onEditPressed: (String value) =>
                            goToWorkExperienceScreen(context, true, value),
                        isExpanded: expandedSection == 'work_experience',
                        onExpansionChanged: (bool value) {
                          setExpandedSection(value ? 'work_experience' : null);
                          if (value) {
                            scrollToSection(
                                context, scrollController, workExperienceKey);
                          }
                        },
                        sectionKey: workExperienceKey,
                      ),
                      const SizedBox(height: 20),
                      EducationWidget(
                        education: educations,
                        onAddPressed: () =>
                            goToEducationScreen(context, false, ""),
                        onEditPressed: (String value) =>
                            goToEducationScreen(context, true, value),
                        isExpanded: expandedSection == 'education',
                        onExpansionChanged: (bool value) {
                          setExpandedSection(value ? 'education' : null);
                          if (value) {
                            scrollToSection(
                                context, scrollController, educationKey);
                          }
                        },
                        sectionKey: educationKey,
                      ),
                      const SizedBox(height: 20),
                      ProjectCard(
                        onAddPressed: () =>
                            goToProjectScreen(context, false, ""),
                        project: projects,
                        onEditPressed: (String value) =>
                            goToProjectScreen(context, true, value),
                        isExpanded: expandedSection == 'projects',
                        onExpansionChanged: (bool value) {
                          setExpandedSection(value ? 'projects' : null);
                          if (value) {
                            scrollToSection(
                                context, scrollController, projectKey);
                          }
                        },
                        sectionKey: projectKey,
                      ),
                      const SizedBox(height: 20),
                      Column(
                        children: [
                          LanguageCard(
                            onAddPressed: () =>
                                goToLanguageScreen(context, false, ""),
                            language: languages,
                            onEditPressed: (String value) =>
                                goToLanguageScreen(context, true, value),
                            isExpanded: expandedSection == 'languages',
                            onExpansionChanged: (bool value) {
                              setExpandedSection(value ? 'languages' : null);
                              if (value) {
                                scrollToSection(
                                    context, scrollController, languageKey);
                              }
                            },
                            sectionKey: languageKey,
                          ),
                          const SizedBox(height: 20),
                          CommonCard(
                            onCardPressed: () => goToSkillScreen(context),
                            headerTitle: "Skills",
                            headerIcon: Icons.pie_chart_sharp,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
