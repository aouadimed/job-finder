import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:cv_frontend/features/job_seeker_home/domain/usecases/filter_job_offer_use_case.dart';
import 'package:cv_frontend/features/job_seeker_home/presentation/bloc/category_bloc/category_bloc.dart';
import 'package:cv_frontend/features/job_seeker_home/presentation/bloc/searsh_page_bloc/search_page_bloc.dart';
import 'package:cv_frontend/features/job_seeker_home/presentation/pages/searsh_screen.dart';
import 'package:cv_frontend/global/common_widget/big_button.dart';
import 'package:cv_frontend/global/common_widget/pop_up_msg.dart';
import 'package:cv_frontend/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:cv_frontend/features/profil/presentation/pages/widgets/utils/scroll_util.dart';
import 'package:cv_frontend/features/job_seeker_home/presentation/pages/widgets/filter_expanble_widget.dart';
import 'package:cv_frontend/features/recruiter_profil/presentation/pages/widgets/country_selection_sheet.dart';
import 'package:cv_frontend/global/common_widget/app_bar.dart';
import 'package:cv_frontend/global/utils/country_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterScreen extends StatefulWidget {
  final FilterJobOfferParams? params;

  const FilterScreen({super.key, this.params});

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
    if (widget.params != null) {
      _preselectFilters(widget.params!);
    }
  }

  @override
  void dispose() {
    _countryController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

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

  Map<String, bool> jobFunction = {};
  Map<String, String> jobFunctionIds = {};

  void _preselectFilters(FilterJobOfferParams params) {
    // Preselect location
    if (params.location.isNotEmpty) {
      _countryController.text = params.location;
    }

    // Preselect work types
    for (int index in params.workTypeIndexes) {
      workType[workType.keys.toList()[index]] = true;
    }

    // Preselect job levels
    for (String level in params.jobLevel) {
      if (jobLevel.containsKey(level)) {
        jobLevel[level] = true;
      }
    }

    // Preselect employment types
    for (int index in params.employmentTypeIndexes) {
      employmentType[employmentType.keys.toList()[index]] = true;
    }

    // Preselect experience
    for (String exp in params.experience) {
      if (experience.containsKey(exp)) {
        experience[exp] = true;
      }
    }

    // Preselect education levels
    for (String edu in params.education) {
      if (education.containsKey(edu)) {
        education[edu] = true;
      }
    }
  }

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
    final selectedJobFunctionIds = jobFunction.entries
        .where((entry) => entry.value)
        .map((entry) => jobFunctionIds[entry.key])
        .whereType<String>()
        .toList();

    final selectedWorkTypeIndexes = workType.entries
        .where((entry) => entry.value)
        .map((entry) => workType.keys.toList().indexOf(entry.key))
        .toList();

    final selectedEmploymentTypeIndexes = employmentType.entries
        .where((entry) => entry.value)
        .map((entry) => employmentType.keys.toList().indexOf(entry.key))
        .toList();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => sl<SearchPageBloc>()
            ..add(FilterJobOfferEvent(
              params: FilterJobOfferParams(
                page: 1,
                location: _countryController.text,
                workTypeIndexes: selectedWorkTypeIndexes,
                jobLevel: jobLevel.entries
                    .where((entry) => entry.value)
                    .map((entry) => entry.key)
                    .toList(),
                employmentTypeIndexes: selectedEmploymentTypeIndexes,
                experience: experience.entries
                    .where((entry) => entry.value)
                    .map((entry) => entry.key)
                    .toList(),
                education: education.entries
                    .where((entry) => entry.value)
                    .map((entry) => entry.key)
                    .toList(),
                jobFunctionIds: selectedJobFunctionIds,
                searchQuery: '',
              ),
            )),
          child: SearchScreen(
            autofocus: false,
            iconColor: primaryColor,
            params: FilterJobOfferParams(
              page: 1,
              location: _countryController.text,
              workTypeIndexes: selectedWorkTypeIndexes,
              jobLevel: jobLevel.entries
                  .where((entry) => entry.value)
                  .map((entry) => entry.key)
                  .toList(),
              employmentTypeIndexes: selectedEmploymentTypeIndexes,
              experience: experience.entries
                  .where((entry) => entry.value)
                  .map((entry) => entry.key)
                  .toList(),
              education: education.entries
                  .where((entry) => entry.value)
                  .map((entry) => entry.key)
                  .toList(),
              jobFunctionIds: selectedJobFunctionIds,
              searchQuery: '',
            ),
            fromFilterScreen: true,
          ),
        ),
      ),
    );
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
              BlocConsumer<CategoryBloc, CategoryState>(
                listener: (context, state) {
                  if (state is CategoryFailure) {
                    showSnackBar(context: context, message: state.message);
                  }
                },
                builder: (context, state) {
                  if (state is CategoryLoading) {
                    return const CircularProgressIndicator();
                  } else if (state is JobCategorySuccess) {
                    if (jobFunction.isEmpty) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        setState(() {
                          jobFunctionIds = {
                            for (var job in state.categorySelectionModel)
                              job.categoryName!: job.categoryId!
                          };
                          jobFunction = {
                            for (var job in state.categorySelectionModel)
                              job.categoryName!: false
                          };
                        });
                      });
                      if (widget.params?.jobFunctionIds != null) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          setState(() {
                            for (String id in widget.params!.jobFunctionIds) {
                              final name = jobFunctionIds.entries
                                  .firstWhere((entry) => entry.value == id,
                                      orElse: () => const MapEntry('', ''))
                                  .key;
                              if (name.isNotEmpty) {
                                jobFunction[name] = true;
                              }
                            }
                          });
                        });
                      }
                    }

                    return FilterExpandableWidget(
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
                    );
                  }
                  return const SizedBox
                      .shrink(); // Return empty widget if no state matches
                },
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
                textColor: primaryColor,
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
