import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:cv_frontend/global/common_widget/text_form_field.dart';
import 'package:cv_frontend/global/utils/form_validator.dart';
import 'package:flutter/material.dart';

class RegisterForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final void Function() registerAction;

  const RegisterForm({
    Key? key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.usernameController,
    required this.registerAction,
  }) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  bool _hidePassword = true;
  bool _hideConfirmPassword = true;

  final FocusNode _usernameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();

  @override
  void dispose() {
    _usernameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          InputField(
            controller: widget.usernameController,
            hint: "User Name",
            prefixIcon: const Icon(Icons.face, color: Colors.grey),
            textInputType: TextInputType.name,
            textInputAction: TextInputAction.next,
            focusNode: _usernameFocusNode,
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_emailFocusNode);
            },
            validator: (value) {
              return FormValidator.validateUsername(value);
            },
          ),
          const SizedBox(height: 16),
          InputField(
            controller: widget.emailController,
            hint: "Email",
            prefixIcon: const Icon(Icons.email, color: Colors.grey),
            textInputType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            focusNode: _emailFocusNode,
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_passwordFocusNode);
            },
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
            textInputAction: TextInputAction.next,
            focusNode: _passwordFocusNode,
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_confirmPasswordFocusNode);
            },
            validator: (value) {
              return FormValidator.validatePassword(value);
            },
          ),
          const SizedBox(height: 16),
          InputField(
            controller: widget.confirmPasswordController,
            hint: "Confirm Password",
            obscureText: _hideConfirmPassword,
            prefixIcon: const Icon(Icons.lock, color: Colors.grey),
            suffixIcon: InkWell(
              onTap: () => {
                setState(() {
                  _hideConfirmPassword = !_hideConfirmPassword;
                })
              },
              child: _hideConfirmPassword
                  ? const Icon(Icons.visibility_off)
                  : const Icon(Icons.visibility),
            ),
            textInputAction: TextInputAction.done,
            focusNode: _confirmPasswordFocusNode,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please confirm your password';
              }
              if (value != widget.passwordController.text) {
                return 'Passwords do not match';
              }
              return null;
            },
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 50.0,
            child: ElevatedButton(
              onPressed: widget.registerAction,
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              child: const Text(
                'SIGN UP',
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
