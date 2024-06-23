import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:cv_frontend/features/profil/data/models/education_model.dart';
import 'package:cv_frontend/features/profil/presentation/bloc/education_bloc/education_bloc.dart';
import 'package:cv_frontend/features/profil/presentation/pages/widgets/common_widget/common_forms_screen.dart';
import 'package:cv_frontend/features/profil/presentation/pages/widgets/forms/education_form.dart';
import 'package:cv_frontend/global/common_widget/pop_up_msg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class EducationScreen extends StatefulWidget {
  final bool isUpdate;
  final String? id;

  const EducationScreen({
    super.key,
    this.isUpdate = false,
    this.id,
  });

  @override
  State<EducationScreen> createState() => _EducationScreenState();
}

class _EducationScreenState extends State<EducationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _schoolTextFieldController =
      TextEditingController();
  final TextEditingController _degreeTextFieldController =
      TextEditingController();
  final TextEditingController _fieldOfStudyTextFieldController =
      TextEditingController();
  final TextEditingController _startDateTextFieldController =
      TextEditingController();
  final TextEditingController _endDateTextFieldController =
      TextEditingController();
  final TextEditingController _gradeTextFieldController =
      TextEditingController();
  final TextEditingController _activitiesTextFieldController =
      TextEditingController();
  final TextEditingController _descriptionTextFieldController =
      TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.isUpdate && widget.id != null) {
      BlocProvider.of<EducationBloc>(context)
          .add(GetSingleEducationEvent(id: widget.id!));
    }
  }

  void _updateFormFields(EducationModel model) {
    _schoolTextFieldController.text = model.school ?? '';
    _degreeTextFieldController.text = model.degree ?? '';
    _fieldOfStudyTextFieldController.text = model.fieldOfStudy ?? '';
    _startDateTextFieldController.text = model.startDate != null
        ? DateFormat.yMMMM().format(model.startDate!)
        : '';
    _endDateTextFieldController.text =
        model.endDate != null ? DateFormat.yMMMM().format(model.endDate!) : '';
    _gradeTextFieldController.text = model.grade ?? '';
    _activitiesTextFieldController.text = model.activitiesAndSocieties ?? '';
    _descriptionTextFieldController.text = model.description ?? '';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EducationBloc, EducationState>(
      listener: (context, state) {
        if (state is EducationFailure) {
          showSnackBar(context: context, message: state.message);
        } else if (state is GetSingleEducationSuccess) {
          _updateFormFields(state.educationModel);
        } else if (state is CreateEducationSuccess) {
          showSnackBar(
            context: context,
            message: "Education saved successfully",
            backgroundColor: greenColor,
          );
        } else if (state is UpdateEducationSuccess) {
          showSnackBar(
            context: context,
            message: "Education updated successfully",
            backgroundColor: greenColor,
          );
        }
      },
      child: BlocBuilder<EducationBloc, EducationState>(
        builder: (context, state) {
          return (state is GetSingleEducationLoading)
              ? Center(
                  child: CircularProgressIndicator(color: primaryColor),
                )
              : CommonFormsScreen(
                  isUpdate: widget.isUpdate,
                  title: 'Education',
                  form: EducationForm(
                    formKey: _formKey,
                    schoolTextFieldController: _schoolTextFieldController,
                    degreeTextFieldController: _degreeTextFieldController,
                    fieldOfStudyTextFieldController:
                        _fieldOfStudyTextFieldController,
                    startDateTextFieldController: _startDateTextFieldController,
                    endDateTextFieldController: _endDateTextFieldController,
                    gradeTextFieldController: _gradeTextFieldController,
                    activitiesTextFieldController:
                        _activitiesTextFieldController,
                    descriptionTextFieldController:
                        _descriptionTextFieldController,
                    selectedStartDateChanged: (String value) {
                      _startDateTextFieldController.text = value;
                    },
                    selectedEndDateChanged: (String value) {
                      _endDateTextFieldController.text = value;
                    },
                  ),
                  onSave: () {
                    if (_formKey.currentState!.validate()) {
                      if (widget.isUpdate) {
                        BlocProvider.of<EducationBloc>(context).add(
                          UpdateEducationEvent(
                            id: widget.id!,
                            school: _schoolTextFieldController.text,
                            degree: _degreeTextFieldController.text,
                            fieldOfStudy: _fieldOfStudyTextFieldController.text,
                            startDate: _startDateTextFieldController.text,
                            endDate: _endDateTextFieldController.text,
                            grade: _gradeTextFieldController.text,
                            activitiesAndSocieties:
                                _activitiesTextFieldController.text,
                            description: _descriptionTextFieldController.text,
                          ),
                        );
                      } else {
                        BlocProvider.of<EducationBloc>(context).add(
                          CreateEducationEvent(
                            school: _schoolTextFieldController.text,
                            degree: _degreeTextFieldController.text,
                            fieldOfStudy: _fieldOfStudyTextFieldController.text,
                            startDate: _startDateTextFieldController.text,
                            endDate: _endDateTextFieldController.text,
                            grade: _gradeTextFieldController.text,
                            activitiesAndSocieties:
                                _activitiesTextFieldController.text,
                            description: _descriptionTextFieldController.text,
                          ),
                        );
                      }
                    }
                  },
                  onDelete: widget.isUpdate
                      ? () {
                          QuickAlert.show(
                            context: context,
                            headerBackgroundColor: primaryColor,
                            type: QuickAlertType.confirm,
                            onConfirmBtnTap: () {
                              BlocProvider.of<EducationBloc>(context)
                                  .add(DeleteEducationEvent(id: widget.id!));
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                          );
                        }
                      : null,
                );
        },
      ),
    );
  }
}

class EducationScreenArguments {
  final bool isUpdate;
  final String id;

  EducationScreenArguments(
    this.id, {
    required this.isUpdate,
  });
}
