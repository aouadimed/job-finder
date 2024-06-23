import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:cv_frontend/features/profil/presentation/pages/widgets/common_widget/common_text_filed.dart';
import 'package:cv_frontend/features/profil/presentation/pages/widgets/selection_widgets.dart/date_selection_sheet.dart';
import 'package:cv_frontend/features/profil/presentation/pages/widgets/selection_widgets.dart/emp_type_sheet.dart';
import 'package:cv_frontend/features/profil/presentation/pages/widgets/selection_widgets.dart/location_type_sheet.dart';
import 'package:cv_frontend/global/common_widget/pop_up_msg.dart';
import 'package:cv_frontend/global/utils/emploments_type_data.dart';
import 'package:cv_frontend/global/utils/location_type_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WorkExperienceForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController jobTitleTextFieldController;
  final TextEditingController empTypeTextFieldController;
  final TextEditingController companyNameTextFieldController;
  final TextEditingController locationTextFieldController;
  final TextEditingController locationTypeTextFieldController;
  final TextEditingController startDateTextFieldController;
  final TextEditingController endDateTextFieldController;
  final TextEditingController descriptionTextFieldController;
  final Function(int) selectedEmplomentTypeIndexChanged;
  final Function(int) selectedLocationTypeIndexChanged;
  final Function(String) selectedStartDateChanged;
  final Function(String) selectedEndDateChanged;
  final Function(bool) ifStillWorkingChanged;
  final int initialEmploymentType;
  final int initialLocationType;
  final bool initialIfStillWorking;

  const WorkExperienceForm({
    super.key,
    required this.formKey,
    required this.jobTitleTextFieldController,
    required this.empTypeTextFieldController,
    required this.companyNameTextFieldController,
    required this.locationTextFieldController,
    required this.locationTypeTextFieldController,
    required this.startDateTextFieldController,
    required this.endDateTextFieldController,
    required this.descriptionTextFieldController,
    required this.selectedEmplomentTypeIndexChanged,
    required this.selectedLocationTypeIndexChanged,
    required this.selectedStartDateChanged,
    required this.selectedEndDateChanged,
    required this.ifStillWorkingChanged,
    this.initialEmploymentType = -1,
    this.initialLocationType = -1,
    this.initialIfStillWorking = false,
  });

  @override
  State<WorkExperienceForm> createState() => _WorkExperienceFormState();
}

class _WorkExperienceFormState extends State<WorkExperienceForm> {
  int selectedEmplomentTypeIndex = -1;
  int selectedLocationTypeIndex = -1;
  bool ifStillWorking = false;
  DateTime? _startDate;
  DateTime? _endDate;

  void validateDates() {
    if (_startDate != null && _endDate != null) {
      if (_endDate!.isBefore(_startDate!)) {
        showSnackBar(
          context: context,
          message: "End date can't be earlier than start date",
          backgroundColor: Colors.red,
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    selectedEmplomentTypeIndex = widget.initialEmploymentType;
    selectedLocationTypeIndex = widget.initialLocationType;
    ifStillWorking = widget.initialIfStillWorking;
    widget.empTypeTextFieldController.text = selectedEmplomentTypeIndex == -1
        ? "Please select"
        : employmentTypes[selectedEmplomentTypeIndex];
    widget.locationTypeTextFieldController.text =
        selectedLocationTypeIndex == -1
            ? "Please select"
            : locationTypes[selectedLocationTypeIndex];
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Expanded(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                CommanInputField(
                    controller: widget.jobTitleTextFieldController,
                    hint: 'Ex: Web Designer',
                    title: 'Job title*'),
                const SizedBox(height: 20),
                CommanInputField(
                  controller: widget.empTypeTextFieldController,
                  hint: 'Please select',
                  hintColor: darkColor,
                  onTap: () async {
                    String? selectedType = await showModalBottomSheet<String>(
                      context: context,
                      elevation: 0,
                      builder: (BuildContext context) {
                        return EmpTypeSheet(
                          onSelect: (String value, int indexValue) {
                            setState(() {
                              selectedEmplomentTypeIndex = indexValue;
                              widget.selectedEmplomentTypeIndexChanged(
                                  selectedEmplomentTypeIndex);
                            });

                            Navigator.pop(context, value);
                          },
                          selectedIndex: selectedEmplomentTypeIndex,
                        );
                      },
                    );
                    if (selectedType != null) {
                      setState(() {
                        widget.empTypeTextFieldController.text = selectedType;
                      });
                    }
                  },
                  suffixIcon: Icons.keyboard_arrow_down_sharp,
                  title: 'Emploment Type',
                  readOnly: true,
                ),
                const SizedBox(height: 20),
                CommanInputField(
                    controller: widget.companyNameTextFieldController,
                    hint: 'Ex: Pinterest',
                    title: 'Company name*'),
                const SizedBox(height: 20),
                CommanInputField(
                    controller: widget.locationTextFieldController,
                    hint: 'Ex: Beja, Tunisia',
                    title: 'Location'),
                const SizedBox(height: 20),
                CommanInputField(
                  controller: widget.locationTypeTextFieldController,
                  hint: 'Please select',
                  hintColor: darkColor,
                  suffixIcon: Icons.keyboard_arrow_down_sharp,
                  title: 'Location Type',
                  onTap: () async {
                    String? selectedType = await showModalBottomSheet<String>(
                      context: context,
                      elevation: 0,
                      builder: (BuildContext context) {
                        return LocationTypeSheet(
                          onSelect: (String value, int indexValue) {
                            setState(() {
                              selectedLocationTypeIndex = indexValue;
                              widget.selectedLocationTypeIndexChanged(
                                  selectedLocationTypeIndex);
                            });
                            Navigator.pop(context, value);
                          },
                          selectedIndex: selectedLocationTypeIndex,
                        );
                      },
                    );
                    if (selectedType != null) {
                      setState(() {
                        widget.locationTypeTextFieldController.text =
                            selectedType;
                      });
                    }
                  },
                  readOnly: true,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Flexible(
                      child: Text(
                        "I currently work here",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Switch(
                        value: ifStillWorking,
                        thumbColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                          if (states.contains(MaterialState.disabled)) {
                            return whiteColor;
                          }
                          return whiteColor;
                        }),
                        trackColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                          if (states.contains(MaterialState.selected)) {
                            return primaryColor;
                          }
                          return greyColor.withOpacity(0.5);
                        }),
                        trackOutlineWidth: MaterialStateProperty.all(0),
                        onChanged: (value) {
                          setState(() {
                            ifStillWorking = value;
                            widget.ifStillWorkingChanged(value);
                          });
                        })
                  ],
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
                                validateDates();
                              });
                            }
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: CommanInputField(
                        enabled: !ifStillWorking,
                        controller: widget.endDateTextFieldController,
                        hint: !ifStillWorking ? 'End date*' : 'Present',
                        textColor: !ifStillWorking ? darkColor : greyColor,
                        hintColor: !ifStillWorking ? darkColor : greyColor,
                        suffixIcon: Icons.keyboard_arrow_down_sharp,
                        title: 'To',
                        readOnly: true,
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
                                    DateFormat.yMMM().format(endDate);
                                widget.selectedEndDateChanged(
                                    endDate.toUtc().toIso8601String());
                                validateDates();
                              });
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                CommanInputField(
                  controller: widget.descriptionTextFieldController,
                  title: 'Description',
                  hint: 'Description',
                  textInputType: TextInputType.multiline,
                  obscureText: false,
                  maxLines: 5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
