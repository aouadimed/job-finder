import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:cv_frontend/features/profil/presentation/bloc/project_bloc/project_bloc.dart';
import 'package:cv_frontend/features/profil/presentation/pages/widgets/common_widget/common_forms_screen.dart';
import 'package:cv_frontend/features/profil/presentation/pages/widgets/forms/project_form.dart';
import 'package:cv_frontend/global/common_widget/pop_up_msg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cv_frontend/features/profil/data/models/project_model.dart';
import 'package:intl/intl.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class ProjectScreen extends StatefulWidget {
  final bool isUpdate;
  final String? id;

  const ProjectScreen({
    super.key,
    this.isUpdate = false,
    this.id,
  });

  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _projectNameTextFieldController =
      TextEditingController();
  final TextEditingController _associatedWithTextFieldController =
      TextEditingController();
  final TextEditingController _startDateTextFieldController =
      TextEditingController();
  final TextEditingController _endDateTextFieldController =
      TextEditingController();
  final TextEditingController _descriptionTextFieldController =
      TextEditingController();
  final TextEditingController _projectUrlTextFieldController =
      TextEditingController();
  late String _selectedStartDate;
  late String _selectedEndDate;
  late String _selectedWorkExperienceId;
  bool _ifStillWorkingOnIt = false;

  @override
  void initState() {
    _selectedStartDate = '';
    _selectedEndDate = '';
    _selectedWorkExperienceId = '';
    super.initState();
  }

  void _updateFormFields(ProjectModel project) {
    _projectNameTextFieldController.text = project.projectName!;
    if (project.startDate != null) {
      _selectedStartDate = DateFormat.yMMMM().format(project.startDate!);
      _startDateTextFieldController.text = _selectedStartDate;
    }
    if (project.endDate != null) {
      _selectedEndDate = DateFormat.yMMMM().format(project.endDate!);
      _endDateTextFieldController.text = _selectedEndDate;
    } else {
      _selectedEndDate = '';
    }
    _descriptionTextFieldController.text = project.description ?? '';
    _projectUrlTextFieldController.text = project.projectUrl ?? '';
    _ifStillWorkingOnIt = project.ifStillWorkingOnIt!;
    _selectedWorkExperienceId = project.workExperience ?? '';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProjectBloc, ProjectState>(
      listener: (context, state) {
        if (state is ProjectFailure) {
          showSnackBar(
            context: context,
            message: state.message,
            backgroundColor: redColor,
          );
        } else if (state is GetSingleProjectSuccess) {
          _updateFormFields(state.project);
        } else if (state is CreateProjectSuccess) {
          showSnackBar(
            context: context,
            message: "Project saved successfully",
            backgroundColor: greenColor,
          );
          Navigator.of(context).pop();
        } else if (state is UpdateProjectSuccess) {
          showSnackBar(
              context: context,
              message: "Project Updated successfully",
              backgroundColor: greenColor);
        }
      },
      child: BlocBuilder<ProjectBloc, ProjectState>(
        builder: (context, state) {
          return CommonFormsScreen(
            title: "Projects",
            isUpdate: widget.isUpdate,
            isLoading: state is GetSingleProjectLoading,
            form: ProjectForm(
              formKey: _formKey,
              projectNameTextFieldController: _projectNameTextFieldController,
              associatedWithTextFieldController:
                  _associatedWithTextFieldController,
              startDateTextFieldController: _startDateTextFieldController,
              endDateTextFieldController: _endDateTextFieldController,
              descriptionTextFieldController: _descriptionTextFieldController,
              projectUrlTextFieldController: _projectUrlTextFieldController,
              ifStillWorkingOnItChanged: (bool value) {
                setState(() {
                  _ifStillWorkingOnIt = value;
                });
              },
              selectedStartDateChanged: (String value) {
                setState(() {
                  _selectedStartDate = value;
                });
              },
              selectedEndDateChanged: (String value) {
                setState(() {
                  _selectedEndDate = value;
                });
              },
              selectedWorkExperienceIdChanged: (String value) {
                setState(() {
                  _selectedWorkExperienceId = value;
                });
              },
              initialIfStillWorkingOnIt: _ifStillWorkingOnIt,
              initialWorkExperienceId: _selectedWorkExperienceId,
            ),
            onSave: () {
              if (_formKey.currentState!.validate()) {
                if (widget.isUpdate) {
                  context.read<ProjectBloc>().add(
                        UpdateProjectEvent(
                          id: widget.id!,
                          projectName: _projectNameTextFieldController.text,
                          workExperience: _selectedWorkExperienceId == ""
                              ? "000000000000000000000000"
                              : _selectedWorkExperienceId,
                          startDate: _selectedStartDate,
                          endDate: _selectedEndDate,
                          description: _descriptionTextFieldController.text,
                          projectUrl: _projectUrlTextFieldController.text,
                          ifStillWorkingOnIt: _ifStillWorkingOnIt,
                        ),
                      );
                } else {
                  context.read<ProjectBloc>().add(
                        CreateProjectEvent(
                          projectName: _projectNameTextFieldController.text,
                          workExperience: _selectedWorkExperienceId == ""
                              ? "000000000000000000000000"
                              : _selectedWorkExperienceId,
                          startDate: _selectedStartDate,
                          endDate: _selectedEndDate,
                          description: _descriptionTextFieldController.text,
                          projectUrl: _projectUrlTextFieldController.text,
                          ifStillWorkingOnIt: _ifStillWorkingOnIt,
                        ),
                      );
                }
              }
            },
            onDelete: widget.isUpdate
                ? () {
                    QuickAlert.show(
                      context: context,
                      confirmBtnColor: primaryColor,
                      type: QuickAlertType.confirm,
                      onConfirmBtnTap: () {
                        BlocProvider.of<ProjectBloc>(context)
                            .add(DeleteProjectEvent(id: widget.id!));
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

class ProjectScreenArguments {
  final bool isUpdate;
  final String id;

  ProjectScreenArguments(
    this.id, {
    required this.isUpdate,
  });
}
