import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:cv_frontend/features/profil/data/models/work_experience_model.dart';
import 'package:cv_frontend/features/profil/presentation/bloc/work_experience_bloc/work_experience_bloc.dart';
import 'package:cv_frontend/features/profil/presentation/pages/widgets/forms/work_experiance_form.dart';
import 'package:cv_frontend/global/common_widget/app_bar.dart';
import 'package:cv_frontend/global/common_widget/big_button.dart';
import 'package:cv_frontend/global/common_widget/pop_up_msg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class WorkExperienceScreen extends StatefulWidget {
  final bool isUpdate;
  final String? id;

  const WorkExperienceScreen({
    super.key,
    this.isUpdate = false,
    this.id,
  });

  @override
  State<WorkExperienceScreen> createState() => _WorkExperienceScreenState();
}

class _WorkExperienceScreenState extends State<WorkExperienceScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _jobTitleTextFieldController;
  late TextEditingController _empTypeTextFieldController;
  late TextEditingController _companyNameTextFieldController;
  late TextEditingController _locationTextFieldController;
  late TextEditingController _locationTypeTextFieldController;
  late TextEditingController _startDateTextFieldController;
  late TextEditingController _endDateTextFieldController;
  late TextEditingController _descriptionTextFieldController;
  late int _selectedEmplomentTypeIndex;
  late int _selectedLocationTypeIndex;
  late String _selectedStartDate;
  late String _selectedEndDate;
  late bool _ifStillWorking;

  @override
  void initState() {
    super.initState();
    _jobTitleTextFieldController = TextEditingController();
    _empTypeTextFieldController = TextEditingController();
    _locationTextFieldController = TextEditingController();
    _locationTypeTextFieldController = TextEditingController();
    _startDateTextFieldController = TextEditingController();
    _endDateTextFieldController = TextEditingController();
    _descriptionTextFieldController = TextEditingController();
    _companyNameTextFieldController = TextEditingController();

    _selectedEmplomentTypeIndex = 0;
    _selectedLocationTypeIndex = 0;
    _selectedStartDate = '';
    _selectedEndDate = '';
    _ifStillWorking = false;
  }

  void _updateFormFields(WorkExperienceModel model) {
    _jobTitleTextFieldController.text = model.jobTitle ?? '';
    _companyNameTextFieldController.text = model.companyName ?? '';
    _locationTextFieldController.text = model.location ?? '';
    _descriptionTextFieldController.text = model.description ?? '';

    _selectedEmplomentTypeIndex = model.employmentType ?? -1;
    _selectedLocationTypeIndex = model.locationType ?? -1;
    _ifStillWorking = model.ifStillWorking ?? false;

    if (model.startDate != null) {
      _selectedStartDate = DateFormat.yMMMM().format(model.startDate!);
      _startDateTextFieldController.text = _selectedStartDate;
    }
    if (model.endDate != null) {
      _selectedEndDate = DateFormat.yMMMM().format(model.endDate!);
      _endDateTextFieldController.text = _selectedEndDate;
    } else {
      _selectedEndDate = '';
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WorkExperienceBloc, WorkExperienceState>(
      listener: (context, state) {
        if (state is WorkExperienceFailure) {
          showSnackBar(context: context, message: state.message);
        } else if (state is GetSingleWorkExperienceSuccess) {
          _updateFormFields(state.workExperiencesModel);
        } else if (state is CreateWorkExperienceSuccess) {
          showSnackBar(
            context: context,
            message: "Work Experience saved successfully",
            backgroundColor: greenColor,
          );
        } else if (state is UpdateWorkExperianceSuccess) {
          showSnackBar(
            context: context,
            message: "Work Experience updaed successfully",
            backgroundColor: greenColor,
          );
        }
      },
      child: BlocBuilder<WorkExperienceBloc, WorkExperienceState>(
        builder: (context, state) {
          return Scaffold(
            appBar: GeneralAppBar(
              titleText: "Work Experience",
              rightIcon: widget.isUpdate ? Icons.delete_outline : null,
              rightIconColor: redColor,
              rightIconOnPressed: widget.isUpdate
                  ? () {
                      QuickAlert.show(
                        context: context,
                        headerBackgroundColor: primaryColor,
                        type: QuickAlertType.confirm,
                        onConfirmBtnTap: () => {
                          BlocProvider.of<WorkExperienceBloc>(context)
                              .add(DeleteWorkExperienceEvent(id: widget.id!)),
                          Navigator.pop(context),
                          Navigator.pop(context)
                        },
                      );
                    }
                  : null,
            ),
            body: SafeArea(
              child: (state is GetSingleWorkExperiencLoading)
                  ? Center(
                      child: CircularProgressIndicator(color: primaryColor),
                    )
                  : Column(
                      children: [
                        WorkExperienceForm(
                          formKey: _formKey,
                          jobTitleTextFieldController:
                              _jobTitleTextFieldController,
                          empTypeTextFieldController:
                              _empTypeTextFieldController,
                          locationTextFieldController:
                              _locationTextFieldController,
                          locationTypeTextFieldController:
                              _locationTypeTextFieldController,
                          startDateTextFieldController:
                              _startDateTextFieldController,
                          endDateTextFieldController:
                              _endDateTextFieldController,
                          descriptionTextFieldController:
                              _descriptionTextFieldController,
                          selectedEmplomentTypeIndexChanged: (int indexValue) {
                            _selectedEmplomentTypeIndex = indexValue;
                          },
                          selectedLocationTypeIndexChanged: (int indexValue) {
                            _selectedLocationTypeIndex = indexValue;
                          },
                          companyNameTextFieldController:
                              _companyNameTextFieldController,
                          selectedStartDateChanged: (String value) {
                            _selectedStartDate = value;
                          },
                          selectedEndDateChanged: (String value) {
                            _selectedEndDate = value;
                          },
                          ifStillWorkingChanged: (bool value) {
                            _ifStillWorking = value;
                          },
                          initialEmploymentType: _selectedEmplomentTypeIndex,
                          initialLocationType: _selectedLocationTypeIndex,
                          initialIfStillWorking: _ifStillWorking,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            children: [
                              const Divider(),
                              const SizedBox(
                                height: 10,
                              ),
                              BigButton(
                                text: 'Save',
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    if (widget.isUpdate) {
                                      BlocProvider.of<WorkExperienceBloc>(
                                              context)
                                          .add(
                                        UpdateWorkExperienceEvent(
                                            jobTitle:
                                                _jobTitleTextFieldController
                                                    .text,
                                            companyName:
                                                _companyNameTextFieldController
                                                    .text,
                                            employmentType:
                                                _selectedEmplomentTypeIndex,
                                            location:
                                                _locationTextFieldController
                                                    .text,
                                            locationType:
                                                _selectedLocationTypeIndex,
                                            description:
                                                _descriptionTextFieldController
                                                    .text,
                                            startDate: _selectedStartDate,
                                            endDate: _selectedEndDate,
                                            ifStillWorking: _ifStillWorking,
                                            id: widget.id!),
                                      );
                                    } else {
                                      BlocProvider.of<WorkExperienceBloc>(
                                              context)
                                          .add(
                                        CreateWorkExperienceEvent(
                                            jobTitle:
                                                _jobTitleTextFieldController
                                                    .text,
                                            companyName:
                                                _companyNameTextFieldController
                                                    .text,
                                            employmentType:
                                                _selectedEmplomentTypeIndex,
                                            location:
                                                _locationTextFieldController
                                                    .text,
                                            locationType:
                                                _selectedLocationTypeIndex,
                                            description:
                                                _descriptionTextFieldController
                                                    .text,
                                            startDate: _selectedStartDate,
                                            endDate: _selectedEndDate,
                                            ifStillWorking: _ifStillWorking),
                                      );
                                    }
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
            ),
          );
        },
      ),
    );
  }
}

class WorkExperienceScreenArguments {
  final bool isUpdate;
  final String id;

  WorkExperienceScreenArguments(
    this.id, {
    required this.isUpdate,
  });
}
