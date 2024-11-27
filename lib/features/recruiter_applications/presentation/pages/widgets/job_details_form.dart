import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:cv_frontend/features/recruiter_applications/presentation/bloc/job_category_bloc/job_category_bloc.dart';
import 'package:cv_frontend/features/recruiter_applications/presentation/pages/widgets/job_category_selection.dart';
import 'package:cv_frontend/features/profil/presentation/pages/widgets/selection_widgets.dart/emp_type_sheet.dart';
import 'package:cv_frontend/features/profil/presentation/pages/widgets/selection_widgets.dart/location_type_sheet.dart';
import 'package:cv_frontend/global/common_widget/common_text_filed.dart';
import 'package:cv_frontend/global/utils/emploments_type_data.dart';
import 'package:cv_frontend/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class JobDetailsPage extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController jobTitleController;
  final TextEditingController empTypeTextFieldController;
  final TextEditingController locationTypeTextFieldController;
  final TextEditingController jobDescriptionController;
  final void Function(String categoryIndex, String subcategoryIndex)
      onCategorySelected;
  final void Function(int index) onEmploymentTypeSelected;
  final void Function(int index) onLocationTypeSelected;
  final int? selectedEmploymentTypeIndex;
  final int? selectedLocationTypeIndex;
  final String? selectedCategoryId;
  final String? selectedSubcategoryId;

  const JobDetailsPage({
    Key? key,
    required this.formKey,
    required this.jobTitleController,
    required this.empTypeTextFieldController,
    required this.locationTypeTextFieldController,
    required this.jobDescriptionController,
    required this.onCategorySelected,
    required this.onEmploymentTypeSelected,
    required this.onLocationTypeSelected,
    this.selectedEmploymentTypeIndex,
    this.selectedLocationTypeIndex,
    this.selectedCategoryId,
    this.selectedSubcategoryId,
  }) : super(key: key);

  @override
  State<JobDetailsPage> createState() => _JobDetailsPageState();
}

class _JobDetailsPageState extends State<JobDetailsPage> {
  late int selectedEmploymentTypeIndex;
  late int selectedLocationTypeIndex;
  late String selectedCategoryId;
  late String selectedSubcategoryId;

  @override
  void initState() {
    super.initState();
    selectedEmploymentTypeIndex = widget.selectedEmploymentTypeIndex ?? 0;
    selectedLocationTypeIndex = widget.selectedLocationTypeIndex ?? 0;
    selectedCategoryId = widget.selectedCategoryId ?? "";
    selectedSubcategoryId = widget.selectedSubcategoryId ?? "";

  }

  final FocusNode empTypeFocusNode = FocusNode();
  final FocusNode companyNameFocusNode = FocusNode();
  final FocusNode locationTypeFocusNode = FocusNode();
  final FocusNode startDateFocusNode = FocusNode();
  final FocusNode descriptionFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    print(selectedCategoryId);
        print(selectedSubcategoryId);

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
                      return BlocProvider(
                        create: (context) => sl<JobCategoryBloc>()
                          ..add(const GetJobCategoryEvent(searshQuery: '')),
                        child: JobCategorySelectionSheet(
                          onSelect: (String categoryId, String subcategoryId,
                              String name) {
                            setState(() {
                              widget.jobTitleController.text = name;
                              selectedCategoryId = categoryId;
                              selectedSubcategoryId = subcategoryId;
                              widget.onCategorySelected(
                                  categoryId, subcategoryId);
                            });
                          },
                          selectedCategoryId: selectedCategoryId,
                          selectedSubcategoryId: selectedSubcategoryId,
                        ),
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
                            selectedEmploymentTypeIndex = indexValue;
                            widget.empTypeTextFieldController.text = value;
                            widget.onEmploymentTypeSelected(indexValue);
                          });

                          Navigator.pop(context, value);
                        },
                        selectedIndex: selectedEmploymentTypeIndex,
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
                            widget.onLocationTypeSelected(indexValue);
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
