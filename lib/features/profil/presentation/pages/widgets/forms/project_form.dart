import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:cv_frontend/features/profil/data/models/work_experience_model.dart';
import 'package:cv_frontend/features/profil/presentation/bloc/work_experience_bloc/work_experience_bloc.dart';
import 'package:cv_frontend/features/profil/presentation/pages/widgets/common_widget/common_switch.dart';
import 'package:cv_frontend/global/common_widget/common_text_filed.dart';
import 'package:cv_frontend/features/profil/presentation/pages/widgets/selection_widgets.dart/asso_with_sheet.dart';
import 'package:cv_frontend/features/profil/presentation/pages/widgets/selection_widgets.dart/date_selection_sheet.dart';
import 'package:cv_frontend/global/common_widget/pop_up_msg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ProjectForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController projectNameTextFieldController;
  final TextEditingController associatedWithTextFieldController;
  final TextEditingController startDateTextFieldController;
  final TextEditingController endDateTextFieldController;
  final TextEditingController descriptionTextFieldController;
  final TextEditingController projectUrlTextFieldController;
  final Function(bool) ifStillWorkingOnItChanged;
  final Function(String) selectedStartDateChanged;
  final Function(String) selectedEndDateChanged;
  final Function(String) selectedWorkExperienceIdChanged;
  final bool initialIfStillWorkingOnIt;
  final String initialWorkExperienceId;

  const ProjectForm({
    super.key,
    required this.formKey,
    required this.projectNameTextFieldController,
    required this.associatedWithTextFieldController,
    required this.startDateTextFieldController,
    required this.endDateTextFieldController,
    required this.descriptionTextFieldController,
    required this.projectUrlTextFieldController,
    required this.ifStillWorkingOnItChanged,
    required this.selectedStartDateChanged,
    required this.selectedEndDateChanged,
    required this.selectedWorkExperienceIdChanged,
    required this.initialIfStillWorkingOnIt,
    required this.initialWorkExperienceId,
  });

  @override
  State<ProjectForm> createState() => _ProjectFormState();
}

class _ProjectFormState extends State<ProjectForm> {
  String selectedWorkExperienceId = '';
  bool ifStillWorkingOnIt = false;
  DateTime? _startDate;
  DateTime? _endDate;
  List<WorkExperiencesModel> experiences = [];

  late FocusNode projectNameFocusNode;
  late FocusNode associatedWithFocusNode;
  late FocusNode startDateFocusNode;
  late FocusNode endDateFocusNode;
  late FocusNode descriptionFocusNode;
  late FocusNode projectUrlFocusNode;

  @override
  void initState() {
    super.initState();
    ifStillWorkingOnIt = widget.initialIfStillWorkingOnIt;
    selectedWorkExperienceId = widget.initialWorkExperienceId;
    _fetchWorkExperiences();

    projectNameFocusNode = FocusNode();
    associatedWithFocusNode = FocusNode();
    startDateFocusNode = FocusNode();
    endDateFocusNode = FocusNode();
    descriptionFocusNode = FocusNode();
    projectUrlFocusNode = FocusNode();
  }

  @override
  void dispose() {
    projectNameFocusNode.dispose();
    associatedWithFocusNode.dispose();
    startDateFocusNode.dispose();
    endDateFocusNode.dispose();
    descriptionFocusNode.dispose();
    projectUrlFocusNode.dispose();
    super.dispose();
  }

  void _fetchWorkExperiences() {
    BlocProvider.of<WorkExperienceBloc>(context).add(GetAllWorkExperienceEvent());
  }

  void _updateWorkExperienceField() {
    if (selectedWorkExperienceId.isNotEmpty && experiences.isNotEmpty) {
      final selectedExperience = experiences.firstWhere(
        (experience) => experience.id == selectedWorkExperienceId,
        orElse: () => WorkExperiencesModel(id: '', jobTitle: '', companyName: ''),
      );

      if (selectedExperience.id != null) {
        widget.associatedWithTextFieldController.text =
            "${selectedExperience.jobTitle} at ${selectedExperience.companyName}";
      } else {
     //   print('No matching work experience found for ID: $selectedWorkExperienceId');
      }
    } else {
//print('No experiences available or selectedWorkExperienceId is empty');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              CommanInputField(
                controller: widget.projectNameTextFieldController,
                hint: '',
                title: 'Project name*',
                focusNode: projectNameFocusNode,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(startDateFocusNode);
                },
              ),
              const SizedBox(height: 20),
              CommonSwitch(
                value: ifStillWorkingOnIt,
                onChanged: (bool value) {
                  setState(() {
                    ifStillWorkingOnIt = value;
                    widget.ifStillWorkingOnItChanged(value);
                  });
                },
                title: 'I am still working on it',
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: CommanInputField(
                      controller: widget.startDateTextFieldController,
                      hint: 'Start date*',
                      hintColor: darkColor,
                      suffixIcon: Icons.keyboard_arrow_down_sharp,
                      title: 'From',
                      readOnly: true,
                      focusNode: startDateFocusNode,
                      textInputAction: TextInputAction.next,
                      onTap: () async {
                        var selectedDate =
                            await showModalBottomSheet<Map<String, int>>(
                          elevation: 0,
                          context: context,
                          builder: (context) => const CustomPicker(),
                        );
                        if (selectedDate != null) {
                          DateTime startDate = DateTime(
                            selectedDate['year']!,
                            selectedDate['month']!,
                          );
                          if (startDate.isAfter(DateTime.now())) {
                            if (context.mounted) {
                              showSnackBar(
                                context: context,
                                message: "Start date can't be in the future",
                                backgroundColor: Colors.red,
                              );
                            }
                          } else {
                            setState(() {
                              _startDate = startDate;
                              widget.startDateTextFieldController.text =
                                  DateFormat.yMMM().format(startDate);
                              widget.selectedStartDateChanged(
                                  startDate.toUtc().toIso8601String());
                            });
                          }
                        }
                      },
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(endDateFocusNode);
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: CommanInputField(
                      enabled: !ifStillWorkingOnIt,
                      controller: widget.endDateTextFieldController,
                      hint: !ifStillWorkingOnIt ? 'End date*' : 'Present',
                      textColor: !ifStillWorkingOnIt ? darkColor : greyColor,
                      hintColor: !ifStillWorkingOnIt ? darkColor : greyColor,
                      suffixIcon: Icons.keyboard_arrow_down_sharp,
                      title: 'To',
                      readOnly: true,
                      focusNode: endDateFocusNode,
                      textInputAction: TextInputAction.next,
                      onTap: () async {
                        var selectedDate =
                            await showModalBottomSheet<Map<String, int>>(
                          elevation: 0,
                          context: context,
                          builder: (context) => const CustomPicker(),
                        );
                        if (selectedDate != null) {
                          DateTime endDate = DateTime(
                            selectedDate['year']!,
                            selectedDate['month']!,
                          );
                          if (endDate.isAfter(DateTime.now())) {
                            if (context.mounted) {
                              showSnackBar(
                                context: context,
                                message: "End date can't be in the future",
                                backgroundColor: Colors.red,
                              );
                            }
                          } else {
                            setState(() {
                              _endDate = endDate;
                              widget.endDateTextFieldController.text =
                                  DateFormat.yMMM().format(_endDate!);
                              widget.selectedEndDateChanged(
                                  endDate.toUtc().toIso8601String());
                            });
                          }
                        }
                      },
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(associatedWithFocusNode);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              BlocListener<WorkExperienceBloc, WorkExperienceState>(
                listener: (context, state) {
                  if (state is GetAllWorkExperienceSuccess) {
                    setState(() {
                      experiences = state.workExperiencesModel;
                      _updateWorkExperienceField();
                    });
                  }
                },
                child: BlocBuilder<WorkExperienceBloc, WorkExperienceState>(
                  builder: (context, state) {
                    return CommanInputField(
                      controller: widget.associatedWithTextFieldController,
                      hint: 'Please select',
                      hintColor: darkColor,
                      suffixIcon: Icons.keyboard_arrow_down_sharp,
                      title: 'Associated with',
                      focusNode: associatedWithFocusNode,
                      textInputAction: TextInputAction.next,
                      onTap: () async {
                        if (experiences.isEmpty) {
                        //  print('Experiences list is empty');
                          return;
                        }

                        String? selectedId = await showModalBottomSheet<String>(
                          context: context,
                          elevation: 0,
                          builder: (BuildContext context) {
                            return SelectionAssoSheet(
                              onSelect: (String idValue, String phraseValue) {
                                setState(() {
                                  selectedWorkExperienceId = idValue;
                                  widget.associatedWithTextFieldController
                                      .text = phraseValue;
                                  widget
                                      .selectedWorkExperienceIdChanged(idValue);
                                });
                                Navigator.pop(context, idValue);
                              },
                              selectedId: selectedWorkExperienceId,
                              list: experiences
                                  .map((e) =>
                                      "${e.jobTitle} at ${e.companyName}")
                                  .toList(),
                              ids: experiences.map((e) => e.id).toList(),
                            );
                          },
                        );
                        if (selectedId != null) {
                          widget.selectedWorkExperienceIdChanged(selectedId);
                        }
                      },
                      readOnly: true,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(descriptionFocusNode);
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 16.0),
              CommanInputField(
                controller: widget.descriptionTextFieldController,
                title: 'Description',
                hint: '',
                textInputType: TextInputType.multiline,
                obscureText: false,
                maxLines: 5,
                focusNode: descriptionFocusNode,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(projectUrlFocusNode);
                },
              ),
              const SizedBox(height: 16.0),
              CommanInputField(
                controller: widget.projectUrlTextFieldController,
                hint: 'EX: www.yourdomain.com/Project URL/',
                title: 'Project URL',
                focusNode: projectUrlFocusNode,
                textInputAction: TextInputAction.done,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
