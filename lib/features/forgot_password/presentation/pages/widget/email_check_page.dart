import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:cv_frontend/global/common_widget/big_button.dart';
import 'package:cv_frontend/global/common_widget/text_form_field.dart';
import 'package:cv_frontend/global/utils/form_validator.dart';
import 'package:cv_frontend/features/forgot_password/presentation/bloc/forgot_password_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmailCheckPage extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailTextFieldController;
  final VoidCallback onNext;

  const EmailCheckPage({
    Key? key,
    required this.formKey,
    required this.emailTextFieldController,
    required this.onNext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Enter your Email",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8.0),
              InputField(
                controller: emailTextFieldController,
                hint: "Email",
                prefixIcon: Icon(Icons.email, color: greyColor),
                textInputType: TextInputType.emailAddress,
                validator: (value) {
                  return FormValidator.validateEmail(value);
                },
              ),
              const SizedBox(height: 20),
              BigButton(
                text: 'Reset password',
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    BlocProvider.of<ForgotPasswordBloc>(context).add(
                      CheckEmailEvent(email: emailTextFieldController.text),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
