import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:cv_frontend/global/common_widget/text_form_field.dart';
import 'package:cv_frontend/global/utils/form_validator.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final void Function() loginAction;
  final bool isLoading;

  const LoginForm({
    Key? key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.loginAction,
    required this.isLoading,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _hidePassword = true;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          InputField(
            controller: widget.emailController,
            hint: "Email",
            prefixIcon: const Icon(Icons.email, color: Colors.grey),
            textInputType: TextInputType.emailAddress,
            validator: (value) {
              return FormValidator.validateEmail(value);
            },
          ),
          const SizedBox(height: 16),
          InputField(
            controller: widget.passwordController,
            hint: "Password",
            obscureText: _hidePassword,
            prefixIcon: const Icon(Icons.lock, color: Colors.grey),
            suffixIcon: InkWell(
              onTap: () => {
                setState(() {
                  _hidePassword = !_hidePassword;
                })
              },
              child: _hidePassword
                  ? const Icon(Icons.visibility_off)
                  : const Icon(Icons.visibility),
            ),
            validator: (value) {
              return FormValidator.validatePassword(value);
            },
          ),
          const SizedBox(height: 30),
          widget.isLoading
              ? const CircularProgressIndicator()
              : SizedBox(
                  width: MediaQuery.of(context)
                      .size
                      .width, // Adjust width as desired
                  height: 50.0, // Adjust height as desired
                  child: ElevatedButton(
                    onPressed: widget.loginAction,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child: const Text(
                      'SIGN IN',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
