import 'package:cv_frontend/core/services/app_routes.dart';
import 'package:cv_frontend/global/common_widget/app_bar.dart';
import 'package:cv_frontend/features/authentication/presentation/pages/widgets/create_or_have_account_section.dart';
import 'package:cv_frontend/features/authentication/presentation/pages/widgets/header_login.dart';
import 'package:cv_frontend/features/authentication/presentation/pages/widgets/register_form.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _usernameTextFieldController;
  late TextEditingController _emailTextFieldController;
  late TextEditingController _passwordTextFieldController;
  late TextEditingController _confirmPasswordController;

  @override
  void initState() {
    _emailTextFieldController = TextEditingController();
    _passwordTextFieldController = TextEditingController();
    _usernameTextFieldController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailTextFieldController.dispose();
    _passwordTextFieldController.dispose();
    _usernameTextFieldController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GeneralAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          reverse: false,
          child: Column(
            children: [
              const LoginHeader(text: 'Create New Account'),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 30,
                  horizontal: 20,
                ),
                child: RegisterForm(
                  formKey: _formKey,
                  emailController: _emailTextFieldController,
                  passwordController: _passwordTextFieldController,
                  usernameController: _usernameTextFieldController,
                  registerAction: () => finshProfil(context),
                  confirmPasswordController: _confirmPasswordController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: CreateOrHaveAccountSection(
                  onTap: () {
                    goBackToLogin(context);
                  },
                  question: "Already have an account?",
                  action: "Sign in",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void goBackToLogin(BuildContext context) {
    Navigator.pop(context);
  }

  void finshProfil(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      Navigator.pushNamed(
        context,
        countryScreen,
        arguments: {
          'username': _usernameTextFieldController.text.trim(),
          'email': _emailTextFieldController.text,
          'password': _passwordTextFieldController.text,
        },
      );
    }
  }
}
