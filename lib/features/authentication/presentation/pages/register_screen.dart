import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:cv_frontend/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:cv_frontend/global/common_widget/app_bar.dart';
import 'package:cv_frontend/features/authentication/presentation/pages/widgets/create_or_have_account_section.dart';
import 'package:cv_frontend/features/authentication/presentation/pages/widgets/header_login.dart';
import 'package:cv_frontend/features/authentication/presentation/pages/widgets/register_form.dart';
import 'package:cv_frontend/features/authentication/presentation/pages/widgets/third_party_login.dart';
import 'package:cv_frontend/global/common_widget/pop_up_msg.dart';
import 'package:cv_frontend/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  @override
  void initState() {
    _emailTextFieldController = TextEditingController();
    _passwordTextFieldController = TextEditingController();
    _usernameTextFieldController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailTextFieldController.dispose();
    _passwordTextFieldController.dispose();
    _usernameTextFieldController.dispose();
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
          } else if (state is RegisterSuccess) {
            showSnackBar(
              context: context,
              message: "Your account was "
                  "created successfully ",
              backgroundColor: greenColor,
            );
            goBackToLogin(context);
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
                          isLoading: state is AuthLoading,
                          usernameController: _usernameTextFieldController,
                          registerAction: () => registerNewUser(context),
                        ),
                      ),
                      const ThirdPartyLogin(),
                      CreateOrHaveAccountSection(
                        onTap: () {
                          goBackToLogin(context);
                        },
                        question: "Already have an account?",
                        action: "Sign in",
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

  void goBackToLogin(BuildContext context) {
    Navigator.pop(context);
  }

  void registerNewUser(BuildContext context) {
    BlocProvider.of<AuthBloc>(context).add(
      RegisterEvent(
        username: _usernameTextFieldController.text.trim(),
        email: _emailTextFieldController.text,
        password: _passwordTextFieldController.text,
      ),
    );
  }
}
