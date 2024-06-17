import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:cv_frontend/core/services/app_routes.dart';
import 'package:cv_frontend/global/common_widget/combo_box.dart';
import 'package:cv_frontend/global/common_widget/text_form_field.dart';
import 'package:cv_frontend/global/utils/country_code_data.dart';
import 'package:cv_frontend/global/utils/form_validator.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController firstnameTextFieldController;
  final TextEditingController usernameTextFieldController;
  final TextEditingController emailTextFieldController;
  final TextEditingController lastnameTextFieldController;
  final TextEditingController dobTextFieldController;
  final TextEditingController numberTextFieldController;
  final TextEditingController genderController;
  final File? image;
  final void Function(File?)? onImageSelected;
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
    required this.image,
    required this.onImageSelected,
    required this.selectedCountry,
  }) : super(key: key);

  @override
  State<ProfilForm> createState() => _ProfilFormState();
}

class _ProfilFormState extends State<ProfilForm> {
  late File? _image;

  @override
  void initState() {
    _image = widget.image; // Initialize _image with widget's image
    super.initState();
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

  Future<void> _getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final File image = File(pickedFile.path);
      setState(() {
        _image = image;
      });
      if (widget.onImageSelected != null) {
        widget.onImageSelected!(image); // Call onImageSelected callback
      }
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
                Stack(
                  alignment: const Alignment(1, 1.2),
                  children: [
                    Container(
                      width: 150.0,
                      height: 150.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.shade200,
                      ),
                      child: _image != null
                          ? ClipOval(
                              child: Image.file(
                                _image!,
                                fit: BoxFit.cover,
                                width: 150.0,
                                height: 150.0,
                              ),
                            )
                          : Icon(
                              Icons.person,
                              color: Colors.grey.shade500,
                              size: 100,
                            ),
                    ),
                    IconButton(
                      onPressed: _getImage,
                      icon: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: primaryColor,
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                InputField(
                  controller: widget.usernameTextFieldController,
                  hint: "Username",
                  prefixIcon: null,
                  textInputType: TextInputType.name,
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
                ),
                const SizedBox(height: 20),
                InputField(
                  controller: widget.lastnameTextFieldController,
                  hint: "Last name",
                  prefixIcon: null,
                  textInputType: TextInputType.name,
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
                      readOnly: true,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                InputField(
                  controller: widget.emailTextFieldController,
                  hint: "E-mail",
                  prefixIcon: const Icon(Icons.email, color: Colors.grey),
                  textInputType: TextInputType.emailAddress,
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
                        enabled: true,
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
                          color: Colors.grey[200],
                        ),
                        child: InputField(
                          controller: widget.numberTextFieldController,
                          hint: "Phone number",
                          prefixIcon: null,
                          textInputType: TextInputType.number,
                        ),
                      ),
                    ),
                  ],
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String countryCodeFromCountryName(String countryName) {
    String? countryCode = countryNameToCode[countryName];
    return countryCode ?? '';
  }

  
  void goToHome(BuildContext context) {
    Navigator.pushReplacementNamed(context, homeScreen);
  }
}
