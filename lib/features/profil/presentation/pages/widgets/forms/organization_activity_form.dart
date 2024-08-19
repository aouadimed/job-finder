import 'package:cv_frontend/global/common_widget/pop_up_msg.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:cv_frontend/global/common_widget/common_text_filed.dart';
import 'package:cv_frontend/features/profil/presentation/pages/widgets/common_widget/common_switch.dart';
import 'package:cv_frontend/features/profil/presentation/pages/widgets/selection_widgets.dart/date_selection_sheet.dart';

class OrganizationActivityForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController organizationTextFieldController;
  final TextEditingController roleTextFieldController;
  final TextEditingController startDateTextFieldController;
  final TextEditingController endDateTextFieldController;
  final TextEditingController descriptionTextFieldController;
  final Function(bool) stillMemberChanged;
  final Function(String) selectedStartDateChanged;
  final Function(String) selectedEndDateChanged;
  final bool initialStillMember;

  const OrganizationActivityForm({
    Key? key,
    required this.formKey,
    required this.organizationTextFieldController,
    required this.roleTextFieldController,
    required this.startDateTextFieldController,
    required this.endDateTextFieldController,
    required this.descriptionTextFieldController,
    required this.stillMemberChanged,
    required this.selectedStartDateChanged,
    required this.selectedEndDateChanged,
    required this.initialStillMember,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              CommanInputField(
                controller: organizationTextFieldController,
                hint: '',
                title: 'Organization*',
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 20),
              CommanInputField(
                controller: roleTextFieldController,
                hint: '',
                title: 'Role*',
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 20),
              CommonSwitch(
                value: initialStillMember,
                onChanged: (bool value) {
                  stillMemberChanged(value);
                },
                title: 'Still a member',
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: CommanInputField(
                      controller: startDateTextFieldController,
                      hint: 'Start Date*',
                      hintColor: Colors.black54,
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
                                  message: "Start date can't be in the future");
                            }
                          } else {
                            startDateTextFieldController.text =
                                DateFormat.yMMM().format(startDate);
                            selectedStartDateChanged(
                                startDate.toUtc().toIso8601String());
                          }
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: CommanInputField(
                      enabled: !initialStillMember,
                      controller: endDateTextFieldController,
                      hint: !initialStillMember ? 'End Date*' : 'Present',
                      hintColor:
                          !initialStillMember ? Colors.black54 : Colors.grey,
                      suffixIcon: Icons.keyboard_arrow_down_sharp,
                      title: 'To',
                      readOnly: true,
                      onTap: !initialStillMember
                          ? () async {
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
                                        message:
                                            "End date can't be in the future");
                                  }
                                } else {
                                  endDateTextFieldController.text =
                                      DateFormat.yMMM().format(endDate);
                                  selectedEndDateChanged(
                                      endDate.toUtc().toIso8601String());
                                }
                              }
                            }
                          : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              CommanInputField(
                controller: descriptionTextFieldController,
                title: 'Description (Optional)',
                hint: '',
                maxLines: 5,
                textInputType: TextInputType.multiline,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
