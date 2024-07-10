import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:cv_frontend/global/common_widget/big_button.dart';
import 'package:cv_frontend/global/common_widget/text_form_field.dart';
import 'package:cv_frontend/global/utils/form_validator.dart';
import 'package:flutter/material.dart';

class ChangePasswordPage extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController passwordTextFieldController;
  final TextEditingController confirmPasswordTextFieldController;

  const ChangePasswordPage({
    Key? key,
    required this.formKey,
    required this.passwordTextFieldController,
    required this.confirmPasswordTextFieldController,
  }) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  bool _hidePassword = true;

  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

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
              const Text(
                "Change password",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8.0),
              InputField(
                controller: widget.passwordTextFieldController,
                hint: "Password",
                obscureText: _hidePassword,
                prefixIcon:  Icon(Icons.lock, color: greyColor),
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
                focusNode: _passwordFocusNode,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_confirmPasswordFocusNode);
                },
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
                  onTap: () => {
                    setState(() {
                      _hidePassword = !_hidePassword;
                    })
                  },
                  child: _hidePassword
                      ? const Icon(Icons.visibility_off)
                      : const Icon(Icons.visibility),
                ),
                focusNode: _confirmPasswordFocusNode,
                textInputAction: TextInputAction.done,
                validator: (value) {
                  return FormValidator.validatePassword(value);
                },
              ),
              const SizedBox(height: 20),
              BigButton(
                text: 'Change password',
                onPressed: () {
                  if (widget.formKey.currentState!.validate()) {
                    // Add your change password logic here
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
