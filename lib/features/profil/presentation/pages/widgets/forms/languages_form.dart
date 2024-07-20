import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:cv_frontend/global/common_widget/common_text_filed.dart';
import 'package:cv_frontend/features/profil/presentation/pages/widgets/selection_widgets.dart/emp_type_sheet.dart';
import 'package:cv_frontend/features/profil/presentation/pages/widgets/selection_widgets.dart/languages_selection_sheet.dart';
import 'package:cv_frontend/global/utils/languages_data.dart';
import 'package:cv_frontend/global/utils/proficiencies_data.dart';
import 'package:flutter/material.dart';

class LanguagesForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;

  final TextEditingController languageController;
  final TextEditingController proficiencyController;
  final Function(int) selectedProficiencyIndexChanged;
  final Function(int) selectedLanguangeIndexChanged;
  final int initialselectedProficiencyIndex;
  final int initialselectedLanguangeIndex;

  const LanguagesForm(
      {super.key,
      required this.selectedProficiencyIndexChanged,
      required this.languageController,
      required this.proficiencyController,
      required this.selectedLanguangeIndexChanged,
      required this.formKey,
      required this.initialselectedProficiencyIndex,
      required this.initialselectedLanguangeIndex});

  @override
  State<LanguagesForm> createState() => _LanguagesFormState();
}

class _LanguagesFormState extends State<LanguagesForm> {
  late int selectedProficiencyIndex ;
  late int selectedLanguangeIndex ;



  @override
  void initState() {
    super.initState();
    selectedProficiencyIndex = widget.initialselectedProficiencyIndex;
    selectedLanguangeIndex = widget.initialselectedLanguangeIndex;
  }
  @override
  Widget build(BuildContext context) {
    return Form(
        key: widget.formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(children: [
              CommanInputField(
                controller: widget.languageController,
                hint: 'Please select',
                hintColor: darkColor,
                onTap: () async {
                  String? selectedLanguage = await showModalBottomSheet<String>(
                    context: context,
                    isScrollControlled: true,
                    useSafeArea: true,
                    elevation: 0,
                    builder: (BuildContext context) {
                      return LanguageSelectionSheet(
                        onSelect: (String value, int indexValue) {
                          setState(() {
                            widget.languageController.text = value;
                            selectedLanguangeIndex = indexValue;
                            widget.selectedLanguangeIndexChanged(
                                selectedLanguangeIndex);
                          });
                        },
                        list: languages,
                        selectedIndex: selectedLanguangeIndex,
                      );
                    },
                  );
                },
                suffixIcon: Icons.keyboard_arrow_down_sharp,
                title: 'Language*',
                readOnly: true,
              ),
              const SizedBox(height: 20),
              CommanInputField(
                controller: widget.proficiencyController,
                hint: 'Please select',
                hintColor: darkColor,
                onTap: () async {
                  String? selectedProficiency =
                      await showModalBottomSheet<String>(
                    context: context,
                    elevation: 0,
                    builder: (BuildContext context) {
                      return SelectionSheet(
                        onSelect: (String value, int indexValue) {
                          setState(() {
                            selectedProficiencyIndex = indexValue;
                            widget.selectedProficiencyIndexChanged(
                                selectedProficiencyIndex);
                          });

                          Navigator.pop(context, value);
                        },
                        selectedIndex: selectedProficiencyIndex,
                        list: proficiencies,
                      );
                    },
                  );
                  if (selectedProficiency != null) {
                    setState(() {
                      widget.proficiencyController.text = selectedProficiency;
                    });
                  }
                },
                suffixIcon: Icons.keyboard_arrow_down_sharp,
                title: 'Proficiency',
                readOnly: true,
              ),
            ]),
          ),
        ));
  }
}
