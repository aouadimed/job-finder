import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:cv_frontend/core/constants/constants.dart';
import 'package:cv_frontend/core/services/app_routes.dart';
import 'package:cv_frontend/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:cv_frontend/global/common_widget/app_bar.dart';
import 'package:cv_frontend/features/authentication/presentation/pages/widgets/create_or_have_account_section.dart';
import 'package:cv_frontend/features/authentication/presentation/pages/widgets/header_login.dart';
import 'package:cv_frontend/features/authentication/presentation/pages/widgets/login_form.dart';
import 'package:cv_frontend/features/authentication/presentation/pages/widgets/third_party_login.dart';
import 'package:cv_frontend/global/common_widget/pop_up_msg.dart';
import 'package:cv_frontend/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cv_frontend/core/services/app_routes.dart' as route;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailTextFieldController;
  late TextEditingController _passwordTextFieldController;

  @override
  void initState() {
    _emailTextFieldController = TextEditingController();
    _passwordTextFieldController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailTextFieldController.dispose();
    _passwordTextFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthBloc>(),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) async {
          if (state is AuthFailure) {
            showSnackBar(context: context, message: state.message);
          } else if (state is LoginSuccess) {
            await _saveLoginDetails(state.userModel.token!);
            await _saveRoleDetails(state.userModel.user!.role!);
            await TokenManager.initialize();
            if (context.mounted) {
              final newInitialRoute = TokenManager.role == 'recruiter'
                  ? route.recruiterNavBar
                  : route.navBar;
              Navigator.of(context).pushNamedAndRemoveUntil(
                newInitialRoute,
                (route) => false,
              );
            }
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return Scaffold(
              appBar: const GeneralAppBar(haveReturn: false),
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const LoginHeader(text: 'Login to your account'),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 30,
                          horizontal: 20,
                        ),
                        child: LoginForm(
                          formKey: _formKey,
                          emailController: _emailTextFieldController,
                          passwordController: _passwordTextFieldController,
                          loginAction: () => handleLogin(context),
                          isLoading: state is AuthLoading,
                        ),
                      ),
                      InkWell(
                        onTap: () => {goToForgotPasswordScreen(context)},
                        child: Text(
                          "Forgot the password ?",
                          style: TextStyle(
                              color: primaryColor,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 25),
                        child: CreateOrHaveAccountSection(
                          onTap: () {
                            goToRegister(context);
                          },
                          question: "Don't have an account?",
                          action: "Sign up",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void handleLogin(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context).add(
        LoginEvent(
          email: _emailTextFieldController.text,
          password: _passwordTextFieldController.text,
        ),
      );
    }
  }

  void goToHome(BuildContext context) {
    Navigator.pushReplacementNamed(context, navBar);
  }

  void goToRegister(BuildContext context) {
    Navigator.pushNamed(context, registerScreen);
  }

  void goToForgotPasswordScreen(BuildContext context) {
    Navigator.pushNamed(context, forgotPassword);
  }

  Future<void> _saveLoginDetails(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_token', token);
  }

  Future<void> _saveRoleDetails(String role) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_role', role);
  }
}
