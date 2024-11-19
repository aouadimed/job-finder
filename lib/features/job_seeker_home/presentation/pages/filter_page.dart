import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:cv_frontend/global/common_widget/big_button.dart';
import 'package:flutter/material.dart';
import 'package:cv_frontend/features/profil/presentation/pages/widgets/utils/scroll_util.dart';
import 'package:cv_frontend/features/job_seeker_home/presentation/pages/widgets/filter_expanble_widget.dart';
import 'package:cv_frontend/features/recruiter_profil/presentation/pages/widgets/country_selection_sheet.dart';
import 'package:cv_frontend/global/common_widget/app_bar.dart';
import 'package:cv_frontend/global/common_widget/text_form_field.dart';
import 'package:cv_frontend/global/utils/country_data.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  late TextEditingController _countryController;
  late ScrollController _scrollController;

  // Expanded section identifier
  String? expandedSection;

  // Keys for each section
  final GlobalKey workTypeKey = GlobalKey();
  final GlobalKey jobLevelKey = GlobalKey();
  final GlobalKey employmentTypeKey = GlobalKey();
  final GlobalKey experienceKey = GlobalKey();
  final GlobalKey educationKey = GlobalKey();
  final GlobalKey jobFunctionKey = GlobalKey();
  final GlobalKey locationKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    _countryController = TextEditingController();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _countryController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // Filter options
  final Map<String, bool> workType = {
    'On-site': false,
    'Hybrid': false,
    'Remote': false,
  };
  final Map<String, bool> jobLevel = {
    'Internship': false,
    'Entry Level': false,
    'Associate / Supervisor': false,
    'Mid-Senior Level / Manager': false,
    'Director / Executive': false,
  };
  final Map<String, bool> employmentType = {
    'Full Time': false,
    'Part Time': false,
    'Self-employed': false,
    'Freelance': false,
    'Contract': false,
    'Internship': false,
    'Apprenticeship': false,
    'Seasonal': false,
  };
  final Map<String, bool> experience = {
    'No Experience': false,
    '1-5 Years': false,
    '6-10 Years': false,
    'More Than 10 Years': false,
  };
  final Map<String, bool> education = {
    'High School': false,
    "Bachelor's Degree": false,
    "Master's Degree": false,
    'PhD': false,
  };
  final Map<String, bool> jobFunction = {
    'IT and Software': false,
    'Media and Creatives': false,
    'Accounting and Finance': false,
  };

  void resetFilters() {
    setState(() {
      _countryController.clear();
      workType.updateAll((key, value) => false);
      jobLevel.updateAll((key, value) => false);
      employmentType.updateAll((key, value) => false);
      experience.updateAll((key, value) => false);
      education.updateAll((key, value) => false);
      jobFunction.updateAll((key, value) => false);
    });
  }

  void applyFilters() {
    final filters = {
      'location': _countryController.text,
      'workType': workType,
      'jobLevel': jobLevel,
      'employmentType': employmentType,
      'experience': experience,
      'education': education,
      'jobFunction': jobFunction,
    };

    print('Applied Filters: $filters');
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GeneralAppBar(
        titleText: 'Filter Options',
        closeicon: true,
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Card(
                  elevation: 0,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 0.4, color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16.0),
                    leading: Icon(Icons.public, color: primaryColor),
                    title: Text(
                      _countryController.text.isNotEmpty
                          ? _countryController.text
                          : 'Select Location',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    trailing:
                        Icon(Icons.keyboard_arrow_down_sharp, color: greyColor),
                    onTap: () async {
                      await showModalBottomSheet<String>(
                        context: context,
                        isScrollControlled: true,
                        useSafeArea: true,
                        builder: (BuildContext context) {
                          return CountrySelectionSheet(
                            allCountries: allCountries,
                            selectedCountry: _countryController.text,
                            onSelect: (String selectedCountry) {
                              setState(() {
                                _countryController.text = selectedCountry;
                              });
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
              FilterExpandableWidget(
                title: 'Work Type',
                icon: Icons.work,
                options: workType,
                onChanged: (key) {
                  setState(() {
                    workType[key] = !workType[key]!;
                  });
                },
                isExpanded: expandedSection == 'workType',
                onExpansionChanged: (expanded) {
                  setState(() {
                    expandedSection = expanded ? 'workType' : null;
                    if (expanded) {
                      scrollToSection(context, _scrollController, workTypeKey);
                    }
                  });
                },
                key: workTypeKey,
              ),
              FilterExpandableWidget(
                title: 'Job Level',
                icon: Icons.bar_chart,
                options: jobLevel,
                onChanged: (key) {
                  setState(() {
                    jobLevel[key] = !jobLevel[key]!;
                  });
                },
                isExpanded: expandedSection == 'jobLevel',
                onExpansionChanged: (expanded) {
                  setState(() {
                    expandedSection = expanded ? 'jobLevel' : null;
                    if (expanded) {
                      scrollToSection(context, _scrollController, jobLevelKey);
                    }
                  });
                },
                key: jobLevelKey,
              ),
              FilterExpandableWidget(
                title: 'Employment Type',
                icon: Icons.business_center,
                options: employmentType,
                onChanged: (key) {
                  setState(() {
                    employmentType[key] = !employmentType[key]!;
                  });
                },
                isExpanded: expandedSection == 'employmentType',
                onExpansionChanged: (expanded) {
                  setState(() {
                    expandedSection = expanded ? 'employmentType' : null;
                    if (expanded) {
                      scrollToSection(
                          context, _scrollController, employmentTypeKey);
                    }
                  });
                },
                key: employmentTypeKey,
              ),
              FilterExpandableWidget(
                title: 'Experience',
                icon: Icons.access_time,
                options: experience,
                onChanged: (key) {
                  setState(() {
                    experience[key] = !experience[key]!;
                  });
                },
                isExpanded: expandedSection == 'experience',
                onExpansionChanged: (expanded) {
                  setState(() {
                    expandedSection = expanded ? 'experience' : null;
                    if (expanded) {
                      scrollToSection(
                          context, _scrollController, experienceKey);
                    }
                  });
                },
                key: experienceKey,
              ),
              FilterExpandableWidget(
                title: 'Education',
                icon: Icons.school,
                options: education,
                onChanged: (key) {
                  setState(() {
                    education[key] = !education[key]!;
                  });
                },
                isExpanded: expandedSection == 'education',
                onExpansionChanged: (expanded) {
                  setState(() {
                    expandedSection = expanded ? 'education' : null;
                    if (expanded) {
                      scrollToSection(context, _scrollController, educationKey);
                    }
                  });
                },
                key: educationKey,
              ),
              FilterExpandableWidget(
                title: 'Job Function',
                icon: Icons.settings,
                options: jobFunction,
                onChanged: (key) {
                  setState(() {
                    jobFunction[key] = !jobFunction[key]!;
                  });
                },
                isExpanded: expandedSection == 'jobFunction',
                onExpansionChanged: (expanded) {
                  setState(() {
                    expandedSection = expanded ? 'jobFunction' : null;
                    if (expanded) {
                      scrollToSection(
                          context, _scrollController, jobFunctionKey);
                    }
                  });
                },
                key: jobFunctionKey,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding:
            const EdgeInsets.only(bottom: 30, left: 20, right: 20, top: 20),
        child: Row(
          children: [
            Expanded(
              child: BigButton(
                onPressed: resetFilters,
                text: 'Reset',
                color: lightprimaryColor,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: BigButton(
                onPressed: applyFilters,
                text: 'Apply',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
