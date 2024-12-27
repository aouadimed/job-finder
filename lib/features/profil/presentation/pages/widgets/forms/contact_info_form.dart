import 'package:country_code_picker/country_code_picker.dart';
import 'package:cv_frontend/global/common_widget/common_text_filed.dart';
import 'package:cv_frontend/global/common_widget/text_form_field.dart';
import 'package:cv_frontend/global/utils/form_validator.dart';
import 'package:cv_frontend/global/utils/functions.dart';
import 'package:flutter/material.dart';

class ContactInfoForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController addressTextFieldController;
  final TextEditingController phoneNumberTextFieldController;
  final TextEditingController emailTextFieldController;
  final String userCountry;
  const ContactInfoForm(
      {super.key,
      required this.formKey,
      required this.addressTextFieldController,
      required this.phoneNumberTextFieldController,
      required this.emailTextFieldController,
      required this.userCountry});

  @override
  State<ContactInfoForm> createState() => _ContactInfoFormState();
}

class _ContactInfoFormState extends State<ContactInfoForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
        key: widget.formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              CommanInputField(
                controller: widget.addressTextFieldController,
                hint: '',
                title: 'Address',
                prefixIcon: const Icon(Icons.location_pin, color: Colors.grey),
              ),
              const SizedBox(height: 16),
              const Text(
                'Phone Number',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8.0),
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
                      initialSelection: 'TN',
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
                        controller: widget.phoneNumberTextFieldController,
                        hint: "",
                        prefixIcon: null,
                        textInputType: TextInputType.number,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              CommanInputField(
                controller: widget.emailTextFieldController,
                hint: '',
                title: 'Email',
                prefixIcon: const Icon(Icons.email, color: Colors.grey),
                textInputType: TextInputType.emailAddress,
                validator: (value) {
                  return FormValidator.validateEmail(value);
                },
              )
            ]),
          ),
        ));
  }
}
