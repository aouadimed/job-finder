import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:cv_frontend/features/profil/presentation/bloc/organization_bloc/organization_activity_bloc.dart';
import 'package:cv_frontend/features/profil/presentation/pages/widgets/common_widget/common_forms_screen.dart';
import 'package:cv_frontend/features/profil/presentation/pages/widgets/forms/organization_activity_form.dart';
import 'package:cv_frontend/global/common_widget/pop_up_msg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cv_frontend/features/profil/data/models/organization_activity_model.dart';
import 'package:intl/intl.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class OrganizationActivityScreen extends StatefulWidget {
  final bool isUpdate;
  final String? id;

  const OrganizationActivityScreen({
    Key? key,
    this.isUpdate = false,
    this.id,
  }) : super(key: key);

  @override
  State<OrganizationActivityScreen> createState() =>
      _OrganizationActivityScreenState();
}

class _OrganizationActivityScreenState
    extends State<OrganizationActivityScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _organizationTextFieldController =
      TextEditingController();
  final TextEditingController _roleTextFieldController =
      TextEditingController();
  final TextEditingController _startDateTextFieldController =
      TextEditingController();
  final TextEditingController _endDateTextFieldController =
      TextEditingController();
  final TextEditingController _descriptionTextFieldController =
      TextEditingController();
  late String _selectedStartDate;
  late String _selectedEndDate;
  bool _stillMember = false;

  @override
  void initState() {
    _selectedStartDate = '';
    _selectedEndDate = '';
    super.initState();
  }

  void _updateFormFields(OrganizationActivityModel activity) {
    _organizationTextFieldController.text = activity.organization!;
    _roleTextFieldController.text = activity.role!;
    if (activity.startDate != null) {
      _selectedStartDate = DateFormat.yMMMM().format(activity.startDate!);
      _startDateTextFieldController.text = _selectedStartDate;
    }
    if (activity.endDate != null) {
      _selectedEndDate = DateFormat.yMMMM().format(activity.endDate!);
      _endDateTextFieldController.text = _selectedEndDate;
    } else {
      _selectedEndDate = '';
    }
    _descriptionTextFieldController.text = activity.description ?? '';
    _stillMember = activity.stillMember!;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrganizationActivityBloc, OrganizationActivityState>(
      listener: (context, state) {
        if (state is OrganizationActivityFailure) {
          showSnackBar(
            context: context,
            message: state.message,
            backgroundColor: redColor,
          );
        } else if (state is GetSingleOrganizationActivitySuccess) {
          _updateFormFields(state.activity);
        } else if (state is CreateOrganizationActivitySuccess) {
          showSnackBar(
            context: context,
            message: "Organization activity saved successfully",
            backgroundColor: greenColor,
          );
          Navigator.of(context).pop();
        } else if (state is UpdateOrganizationActivitySuccess) {
          showSnackBar(
            context: context,
            message: "Organization activity updated successfully",
            backgroundColor: greenColor,
          );
        }
      },
      child: BlocBuilder<OrganizationActivityBloc, OrganizationActivityState>(
        builder: (context, state) {
          return CommonFormsScreen(
            title: "Organization Activities",
            isUpdate: widget.isUpdate,
            isLoading: state is GetSingleOrganizationActivityLoading,
            form: OrganizationActivityForm(
              formKey: _formKey,
              organizationTextFieldController: _organizationTextFieldController,
              roleTextFieldController: _roleTextFieldController,
              startDateTextFieldController: _startDateTextFieldController,
              endDateTextFieldController: _endDateTextFieldController,
              descriptionTextFieldController: _descriptionTextFieldController,
              stillMemberChanged: (bool value) {
                setState(() {
                  _stillMember = value;
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
              initialStillMember: _stillMember,
            ),
            onSave: () {
              if (_formKey.currentState!.validate()) {
                if (widget.isUpdate) {
                  context.read<OrganizationActivityBloc>().add(
                        UpdateOrganizationActivityEvent(
                          id: widget.id!,
                          organization: _organizationTextFieldController.text,
                          role: _roleTextFieldController.text,
                          startDate: _selectedStartDate,
                          endDate: _selectedEndDate,
                          description: _descriptionTextFieldController.text,
                          stillMember: _stillMember,
                        ),
                      );
                } else {
                  context.read<OrganizationActivityBloc>().add(
                        CreateOrganizationActivityEvent(
                          organization: _organizationTextFieldController.text,
                          role: _roleTextFieldController.text,
                          startDate: _selectedStartDate,
                          endDate: _selectedEndDate,
                          description: _descriptionTextFieldController.text,
                          stillMember: _stillMember,
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
                      confirmBtnColor: primaryColor,
                      type: QuickAlertType.confirm,
                      onConfirmBtnTap: () {
                        BlocProvider.of<OrganizationActivityBloc>(context).add(
                            DeleteOrganizationActivityEvent(id: widget.id!));
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

class OrganizationActivityScreenArguments {
  final bool isUpdate;
  final String id;

  OrganizationActivityScreenArguments(
    this.id, {
    required this.isUpdate,
  });
}
