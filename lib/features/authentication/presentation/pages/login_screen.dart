import 'package:cv_frontend/core/constants/appcolors.dart';
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
        listener: (context, state) {
          if (state is AuthFailure) {
            showSnackBar(context: context, message: state.message);
          } else if (state is LoginSuccess) {
            goToHome(context);
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return Scaffold(
              appBar: const GenearalAppBar(),
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
                        onTap: () => {},
                        child: Text(
                          "Forgot the password ?",
                          style: TextStyle(
                              color: primaryColor,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 25),
                        child: ThirdPartyLogin(),
                      ),
                      CreateOrHaveAccountSection(
                        onTap: () {
                          goToRegister(context);
                        },
                        question: "Don't have an account?",
                        action: "Sign up",
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
    Navigator.pushReplacementNamed(context, homeScreen);
  }

  void goToRegister(BuildContext context) {
    Navigator.pushNamed(context, registerScreen);
  }
}
