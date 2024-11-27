import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:cv_frontend/features/profil/data/models/language_model.dart';
import 'package:cv_frontend/features/profil/presentation/bloc/languages_bloc/language_bloc.dart';
import 'package:cv_frontend/features/profil/presentation/pages/widgets/common_widget/common_forms_screen.dart';
import 'package:cv_frontend/features/profil/presentation/pages/widgets/forms/languages_form.dart';
import 'package:cv_frontend/global/common_widget/pop_up_msg.dart';
import 'package:cv_frontend/global/utils/languages_data.dart';
import 'package:cv_frontend/global/utils/proficiencies_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class LanguagesScreen extends StatefulWidget {
  final bool isUpdate;
  final String? id;

  const LanguagesScreen({
    super.key,
    this.isUpdate = false,
    this.id,
  });

  @override
  State<LanguagesScreen> createState() => _LanguagesScreenState();
}

class _LanguagesScreenState extends State<LanguagesScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _languageController = TextEditingController();
  final TextEditingController _proficiencyController = TextEditingController();
  late int _selectedLanguageIndex;
  late int _selectedProficiencyIndex;

  @override
  void initState() {
    _selectedLanguageIndex = -1;
    _selectedProficiencyIndex = 0;
    super.initState();

    if (widget.isUpdate && widget.id != null) {
      context.read<LanguageBloc>().add(GetSingleLanguageEvent(id: widget.id!));
    }
  }

  void _updateFormFields(LanguageModel language) {
    _languageController.text = languages[language.language!];
    _proficiencyController.text = language.proficiencyIndex != null
        ? proficiencies[language.proficiencyIndex!]
        : '';
    _selectedLanguageIndex = language.language!;
    _selectedProficiencyIndex = language.proficiencyIndex ?? -1;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LanguageBloc, LanguageState>(
      listener: (context, state) {
        if (state is LanguageFailure) {
          showSnackBar(
            context: context,
            message: state.message,
            backgroundColor: redColor,
          );
        } else if (state is GetSingleLanguageSuccess) {
          _updateFormFields(state.language);
        } else if (state is CreateLanguageSuccess) {
          showSnackBar(
            context: context,
            message: "Language added successfully",
            backgroundColor: greenColor,
          );
          Navigator.of(context).pop();
        } else if (state is UpdateLanguageSuccess) {
          showSnackBar(
            context: context,
            message: "Language updated successfully",
            backgroundColor: greenColor,
          );
        }
      },
      child: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, state) {
          return CommonFormsScreen(
            title: "Languages",
            isUpdate: widget.isUpdate,
            isLoading: state is GetSingleLanguageLoading,
            form: LanguagesForm(
              formKey: _formKey,
              languageController: _languageController,
              proficiencyController: _proficiencyController,
              selectedLanguangeIndexChanged: (int value) {
                setState(() {
                  _selectedLanguageIndex = value;
                });
              },
              selectedProficiencyIndexChanged: (int value) {
                setState(() {
                  _selectedProficiencyIndex = value;
                });
              },
              initialselectedProficiencyIndex: _selectedProficiencyIndex,
              initialselectedLanguangeIndex: _selectedLanguageIndex,
            ),
            onSave: () {
              if (_formKey.currentState!.validate()) {
                if (_selectedLanguageIndex == -1) {
                  showSnackBar(
                    context: context,
                    message: "Please select a language",
                    backgroundColor: redColor,
                  );
                  return;
                }

                if (widget.isUpdate) {
                  context.read<LanguageBloc>().add(
                        UpdateLanguageEvent(
                          id: widget.id!,
                          language: _selectedLanguageIndex,
                          proficiencyIndex: _selectedProficiencyIndex,
                        ),
                      );
                } else {
                  context.read<LanguageBloc>().add(
                        CreateLanguageEvent(
                          language: _selectedLanguageIndex,
                          proficiencyIndex: _selectedProficiencyIndex,
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
                        context.read<LanguageBloc>().add(
                              DeleteLanguageEvent(id: widget.id!),
                            );
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

class LanguagesScreenArguments {
  final bool isUpdate;
  final String id;

  LanguagesScreenArguments(
    this.id, {
    required this.isUpdate,
  });
}
