import 'package:country_code_picker/country_code_picker.dart';
import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:cv_frontend/core/services/app_routes.dart';
import 'package:cv_frontend/global/common_widget/combo_box.dart';
import 'package:cv_frontend/global/common_widget/text_form_field.dart';
import 'package:cv_frontend/global/utils/form_validator.dart';
import 'package:cv_frontend/global/utils/functions.dart';
import 'package:flutter/material.dart';

class ProfilForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController firstnameTextFieldController;
  final TextEditingController usernameTextFieldController;
  final TextEditingController emailTextFieldController;
  final TextEditingController lastnameTextFieldController;
  final TextEditingController dobTextFieldController;
  final TextEditingController numberTextFieldController;
  final TextEditingController genderController;
  final TextEditingController addressTextFieldController;
  final String? selectedCountry;

  const ProfilForm({
    Key? key,
    required this.formKey,
    required this.firstnameTextFieldController,
    required this.usernameTextFieldController,
    required this.emailTextFieldController,
    required this.lastnameTextFieldController,
    required this.dobTextFieldController,
    required this.numberTextFieldController,
    required this.genderController,
    required this.selectedCountry,
    required this.addressTextFieldController,
  }) : super(key: key);

  @override
  State<ProfilForm> createState() => _ProfilFormState();
}

class _ProfilFormState extends State<ProfilForm> {
  final _usernameFocusNode = FocusNode();
  final _firstnameFocusNode = FocusNode();
  final _lastnameFocusNode = FocusNode();
  final _dobFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _phoneNumberFocusNode = FocusNode();
  final _addressFocusNode = FocusNode();
  final _genderFocusNode = FocusNode();

  @override
  void dispose() {
    _usernameFocusNode.dispose();
    _firstnameFocusNode.dispose();
    _lastnameFocusNode.dispose();
    _dobFocusNode.dispose();
    _emailFocusNode.dispose();
    _phoneNumberFocusNode.dispose();
    _addressFocusNode.dispose();
    _genderFocusNode.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime eighteenYearsAgo =
        DateTime.now().subtract(const Duration(days: 18 * 365));
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: eighteenYearsAgo,
      firstDate: DateTime(1900),
      lastDate: eighteenYearsAgo,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: primaryColor,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        widget.dobTextFieldController.text = picked.toString().split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Expanded(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 20),
                InputField(
                  controller: widget.usernameTextFieldController,
                  hint: "Username",
                  prefixIcon: null,
                  textInputType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  focusNode: _usernameFocusNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_firstnameFocusNode);
                  },
                  validator: (value) {
                    return FormValidator.validateUsername(value);
                  },
                ),
                const SizedBox(height: 20),
                InputField(
                  controller: widget.firstnameTextFieldController,
                  hint: "First name",
                  prefixIcon: null,
                  textInputType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  focusNode: _firstnameFocusNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_lastnameFocusNode);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your first name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                InputField(
                  controller: widget.lastnameTextFieldController,
                  hint: "Last name",
                  prefixIcon: null,
                  textInputType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  focusNode: _lastnameFocusNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_dobFocusNode);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your last name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () => _selectDate(context),
                  child: AbsorbPointer(
                    child: InputField(
                      controller: widget.dobTextFieldController,
                      hint: "Date of birth",
                      prefixIcon:
                          const Icon(Icons.date_range, color: Colors.grey),
                      textInputType: TextInputType.datetime,
                      textInputAction: TextInputAction.next,
                      focusNode: _dobFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_emailFocusNode);
                      },
                      readOnly: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select your date of birth';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                InputField(
                  controller: widget.emailTextFieldController,
                  hint: "E-mail",
                  prefixIcon: const Icon(Icons.email, color: Colors.grey),
                  textInputType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  focusNode: _emailFocusNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_phoneNumberFocusNode);
                  },
                  validator: (value) {
                    return FormValidator.validateEmail(value);
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Container(
                      width: 130,
                      margin: const EdgeInsets.only(right: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.grey[200],
                      ),
                      child: CountryCodePicker(
                        onChanged: (c) => c.code,
                        enabled: false,
                        initialSelection: countryCodeFromCountryName(
                            widget.selectedCountry ?? ""),
                        showCountryOnly: true,
                        flagWidth: 20,
                        textStyle:
                            const TextStyle(fontSize: 15, color: Colors.black),
                        showOnlyCountryWhenClosed: false,
                        alignLeft: false,
                        flagDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.transparent,
                        ),
                        child: InputField(
                          controller: widget.numberTextFieldController,
                          hint: "Phone number",
                          prefixIcon: null,
                          textInputType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          focusNode: _phoneNumberFocusNode,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_addressFocusNode);
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your phone number';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                InputField(
                  controller: widget.addressTextFieldController,
                  hint: "Address",
                  prefixIcon:
                      const Icon(Icons.location_pin, color: Colors.grey),
                  textInputType: TextInputType.streetAddress,
                  textInputAction: TextInputAction.next,
                  focusNode: _addressFocusNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_genderFocusNode);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ComboBoxField(
                  selectedValue: widget.genderController.text,
                  items: const ["Male", "Female"],
                  hint: 'Gender',
                  onChanged: (String? value) {
                    setState(() {
                      widget.genderController.text = value ?? "";
                    });
                  },
                  focusNode: _genderFocusNode,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select your gender';
                    }
                    return null;
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void goToHome(BuildContext context) {
    Navigator.pushReplacementNamed(context, homeScreen);
  }
}
