import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:cv_frontend/features/recruiter_applications/presentation/pages/widgets/job_category_selection.dart';
import 'package:cv_frontend/features/profil/presentation/pages/widgets/selection_widgets.dart/emp_type_sheet.dart';
import 'package:cv_frontend/features/profil/presentation/pages/widgets/selection_widgets.dart/location_type_sheet.dart';
import 'package:cv_frontend/global/common_widget/common_text_filed.dart';
import 'package:cv_frontend/global/utils/emploments_type_data.dart';
import 'package:cv_frontend/global/utils/job_category_data.dart';
import 'package:flutter/material.dart';

class JobDetailsPage extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController jobTitleController;
  final TextEditingController empTypeTextFieldController;
  final TextEditingController locationTypeTextFieldController;
  final TextEditingController jobDescriptionController;

  const JobDetailsPage({
    Key? key,
    required this.formKey,
    required this.jobTitleController,
    required this.empTypeTextFieldController,
    required this.locationTypeTextFieldController,
    required this.jobDescriptionController,
  }) : super(key: key);

  @override
  State<JobDetailsPage> createState() => _JobDetailsPageState();
}

class _JobDetailsPageState extends State<JobDetailsPage> {
  int selectedEmplomentTypeIndex = 0;
  int selectedLocationTypeIndex = 0;
  int selectedCategoryIndex = -1;
  int selectedSubcategoryIndex = -1;
  final FocusNode empTypeFocusNode = FocusNode();
  final FocusNode companyNameFocusNode = FocusNode();
  final FocusNode locationTypeFocusNode = FocusNode();
  final FocusNode startDateFocusNode = FocusNode();
  final FocusNode descriptionFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: widget.formKey,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommanInputField(
                controller: widget.jobTitleController,
                hint: 'Please select',
                hintColor: darkColor,
                onTap: () async {
                  await showModalBottomSheet<String>(
                    context: context,
                    isScrollControlled: true,
                    useSafeArea: true,
                    elevation: 0,
                    builder: (BuildContext context) {
                      return JobCategorySelectionSheet(
                        onSelect: (String value, int categoryIndex,
                            int subcategoryIndex) {
                          setState(() {
                            widget.jobTitleController.text = value;
                            selectedCategoryIndex = categoryIndex;
                            selectedSubcategoryIndex = subcategoryIndex;
                            print("$categoryIndex ,$subcategoryIndex");
                          });
                        },
                        list: jobCategories,
                        selectedCategoryIndex: selectedCategoryIndex,
                        selectedSubcategoryIndex: selectedSubcategoryIndex,
                      );
                    },
                  );
                },
                suffixIcon: Icons.keyboard_arrow_down_sharp,
                title: 'Job Title',
                readOnly: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a job title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              CommanInputField(
                controller: widget.empTypeTextFieldController,
                hint: 'Please select',
                hintColor: Colors.black,
                focusNode: empTypeFocusNode,
                textInputAction: TextInputAction.next,
                onTap: () async {
                  String? selectedType = await showModalBottomSheet<String>(
                    context: context,
                    elevation: 0,
                    builder: (BuildContext context) {
                      return SelectionSheet(
                        onSelect: (String value, int indexValue) {
                          setState(() {
                            selectedEmplomentTypeIndex = indexValue;
                            widget.empTypeTextFieldController.text = value;
                          });

                          Navigator.pop(context, value);
                        },
                        selectedIndex: selectedEmplomentTypeIndex,
                        list: employmentTypes,
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
                title: 'Employment Type',
                readOnly: true,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(companyNameFocusNode);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select an employment type';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              CommanInputField(
                controller: widget.locationTypeTextFieldController,
                hint: 'Please select',
                hintColor: Colors.black,
                suffixIcon: Icons.keyboard_arrow_down_sharp,
                title: 'Location Type',
                readOnly: true,
                focusNode: locationTypeFocusNode,
                textInputAction: TextInputAction.next,
                onTap: () async {
                  String? selectedType = await showModalBottomSheet<String>(
                    context: context,
                    elevation: 0,
                    builder: (BuildContext context) {
                      return LocationTypeSheet(
                        onSelect: (String value, int indexValue) {
                          setState(() {
                            selectedLocationTypeIndex = indexValue;
                            widget.locationTypeTextFieldController.text = value;
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
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(startDateFocusNode);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a location type';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              CommanInputField(
                controller: widget.jobDescriptionController,
                title: 'Job Description',
                hint: '(Max 500 characters)',
                textInputType: TextInputType.multiline,
                obscureText: false,
                maxLines: 10,
                maxLength: 500,
                focusNode: descriptionFocusNode,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a job description';
                  }
                  return null;
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
