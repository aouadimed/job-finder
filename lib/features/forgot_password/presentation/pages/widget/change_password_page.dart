import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:cv_frontend/features/forgot_password/presentation/bloc/forgot_password_bloc.dart';
import 'package:cv_frontend/global/common_widget/big_button.dart';
import 'package:cv_frontend/global/common_widget/pop_up_msg.dart';
import 'package:cv_frontend/global/common_widget/text_form_field.dart';
import 'package:cv_frontend/global/utils/form_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordPage extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController passwordTextFieldController;
  final TextEditingController confirmPasswordTextFieldController;
  final String email;

  const ChangePasswordPage({
    Key? key,
    required this.formKey,
    required this.passwordTextFieldController,
    required this.confirmPasswordTextFieldController,
    required this.email,
  }) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  bool _hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: widget.formKey,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text(
                "Change password",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.normal,
                  color: darkColor,
                ),
              ),
              const SizedBox(height: 8.0),
              InputField(
                controller: widget.passwordTextFieldController,
                hint: "Password",
                obscureText: _hidePassword,
                prefixIcon: const Icon(Icons.lock, color: Colors.grey),
                suffixIcon: InkWell(
                  onTap: () => setState(() {
                    _hidePassword = !_hidePassword;
                  }),
                  child: _hidePassword
                      ? const Icon(Icons.visibility_off)
                      : const Icon(Icons.visibility),
                ),
                validator: (value) {
                  return FormValidator.validatePassword(value);
                },
              ),
              const SizedBox(height: 20),
              InputField(
                controller: widget.confirmPasswordTextFieldController,
                hint: "Confirm new password",
                obscureText: _hidePassword,
                prefixIcon:  Icon(Icons.lock, color: greyColor),
                suffixIcon: InkWell(
                  onTap: () => setState(() {
                    _hidePassword = !_hidePassword;
                  }),
                  child: _hidePassword
                      ? const Icon(Icons.visibility_off)
                      : const Icon(Icons.visibility),
                ),
                validator: (value) {
                  return FormValidator.validatePassword(value);
                },
              ),
              const SizedBox(height: 20),
              BigButton(
                text: 'Change password',
                onPressed: () {
                  if (widget.formKey.currentState!.validate()) {
                    if (widget.passwordTextFieldController.text ==
                        widget.confirmPasswordTextFieldController.text) {
                      BlocProvider.of<ForgotPasswordBloc>(context).add(
                        ChangePasswordEvent(
                            email: widget.email,
                            newPassword:
                                widget.passwordTextFieldController.text),
                      );
                    } else {
                      showSnackBar(
                          context: context, message: "Passwords don't match");
                    }
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
