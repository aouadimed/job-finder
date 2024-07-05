import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:cv_frontend/features/profil/presentation/pages/widgets/common_widget/common_text_filed.dart';
import 'package:cv_frontend/features/profil/presentation/pages/widgets/selection_widgets.dart/date_selection_sheet.dart';
import 'package:cv_frontend/global/common_widget/pop_up_msg.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class EducationForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController schoolTextFieldController;
  final TextEditingController degreeTextFieldController;
  final TextEditingController fieldOfStudyTextFieldController;
  final TextEditingController startDateTextFieldController;
  final TextEditingController endDateTextFieldController;
  final TextEditingController gradeTextFieldController;
  final TextEditingController activitiesTextFieldController;
  final TextEditingController descriptionTextFieldController;
  final Function(String) selectedStartDateChanged;
  final Function(String) selectedEndDateChanged;

  const EducationForm({
    super.key,
    required this.formKey,
    required this.schoolTextFieldController,
    required this.degreeTextFieldController,
    required this.fieldOfStudyTextFieldController,
    required this.startDateTextFieldController,
    required this.endDateTextFieldController,
    required this.gradeTextFieldController,
    required this.activitiesTextFieldController,
    required this.descriptionTextFieldController,
    required this.selectedStartDateChanged,
    required this.selectedEndDateChanged,
  });

  @override
  State<EducationForm> createState() => _EducationFormState();
}

class _EducationFormState extends State<EducationForm> {
  DateTime? _startDate;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CommanInputField(
              controller: widget.schoolTextFieldController,
              hint: 'Ex: Esprit University',
              title: 'School*',
            ),
            const SizedBox(height: 16),
            CommanInputField(
              controller: widget.degreeTextFieldController,
              hint: 'Ex: Bachelor\'s',
              title: 'Degree',
            ),
            const SizedBox(height: 16),
            CommanInputField(
              controller: widget.fieldOfStudyTextFieldController,
              hint: 'Ex: Accounting',
              title: 'Field of study*',
            ),
            const SizedBox(height: 16),
            CommanInputField(
              controller: widget.startDateTextFieldController,
              hint: 'Start date*',
              hintColor: darkColor,
              suffixIcon: Icons.keyboard_arrow_down_sharp,
              title: 'From',
              readOnly: true,
              onTap: () async {
                var selectedDate = await showModalBottomSheet<Map<String, int>>(
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
                        backgroundColor: redColor,
                      );
                    }
                  } else {
                    setState(() {
                      _startDate = startDate;
                      widget.startDateTextFieldController.text =
                          DateFormat.yMMM().format(startDate);
                      widget.selectedStartDateChanged(
                          startDate.toIso8601String());
                    });
                  }
                }
              },
            ),
            const SizedBox(height: 16),
            CommanInputField(
              controller: widget.endDateTextFieldController,
              hint: 'End date (or expected)*',
              textColor: darkColor,
              hintColor: darkColor,
              suffixIcon: Icons.keyboard_arrow_down_sharp,
              title: 'To',
              readOnly: true,
              onTap: () async {
                var selectedDate = await showModalBottomSheet<Map<String, int>>(
                  elevation: 0,
                  context: context,
                  builder: (context) => const CustomPicker(),
                );
                if (selectedDate != null) {
                  DateTime endDate = DateTime(
                    selectedDate['year']!,
                    selectedDate['month']!,
                  );
                  if (_startDate != null && endDate.isBefore(_startDate!)) {
                    if (context.mounted) {
                      showSnackBar(
                        context: context,
                        message: "End date can't be earlier than start date",
                        backgroundColor: redColor,
                      );
                    }
                  } else {
                    setState(() {
                      widget.endDateTextFieldController.text =
                          DateFormat.yMMM().format(endDate);
                      widget.selectedEndDateChanged(endDate.toIso8601String());
                    });
                  }
                }
              },
            ),
            const SizedBox(height: 16.0),
            CommanInputField(
              controller: widget.gradeTextFieldController,
              hint: '',
              title: 'Grade',
            ),
            const SizedBox(height: 16.0),
            CommanInputField(
              controller: widget.activitiesTextFieldController,
              hint: 'Ex : IEEE, Tunivision, Volleyball',
              title: 'Activities and societies',
            ),
            const SizedBox(height: 16.0),
            CommanInputField(
              controller: widget.descriptionTextFieldController,
              title: 'Description',
              hint: '',
              textInputType: TextInputType.multiline,
              obscureText: false,
              maxLines: 5,
            ),
          ],
        ),
      ),
    );
  }
}
