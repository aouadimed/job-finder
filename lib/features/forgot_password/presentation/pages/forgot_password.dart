import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:cv_frontend/features/forgot_password/presentation/bloc/forgot_password_bloc.dart';
import 'package:cv_frontend/features/forgot_password/presentation/pages/widget/change_password_page.dart';
import 'package:cv_frontend/features/forgot_password/presentation/pages/widget/email_check_page.dart';
import 'package:cv_frontend/features/forgot_password/presentation/pages/widget/otp_verification_page.dart';
import 'package:cv_frontend/global/common_widget/app_bar.dart';
import 'package:cv_frontend/global/common_widget/pop_up_msg.dart';
import 'package:cv_frontend/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:cv_frontend/features/authentication/presentation/pages/widgets/header_login.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  late TextEditingController _emailTextFieldController;
  late TextEditingController _otpTextFieldController;
  late TextEditingController _passwordTextFieldController;
  late TextEditingController _confirmPasswordTextFieldController;
  bool isOtpSent = false;

  final PageController _pageController = PageController();

  @override
  void initState() {
    _emailTextFieldController = TextEditingController();
    _otpTextFieldController = TextEditingController();
    _passwordTextFieldController = TextEditingController();
    _confirmPasswordTextFieldController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailTextFieldController.dispose();
    _otpTextFieldController.dispose();
    _passwordTextFieldController.dispose();
    _confirmPasswordTextFieldController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _goToNextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ForgotPasswordBloc>(),
      child: BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
        listener: (context, state) {
          if (state is ForgotPasswordFailure) {
            showSnackBar(context: context, message: state.message);
          } else if (state is ForgotPasswordSuccess) {
            QuickAlert.show(
              text: "Check inbox",
              context: context,
              headerBackgroundColor: primaryColor,
              type: QuickAlertType.success,
            );
            _goToNextPage();
          } else if (state is CodeVerificationSuccess) {
            QuickAlert.show(
              text: "Verification success",
              context: context,
              headerBackgroundColor: primaryColor,
              type: QuickAlertType.success,
            );
            _goToNextPage();
          } else if (state is ChangePasswordSuccess) {
            QuickAlert.show(
              text: "Password has been updated",
              context: context,
              headerBackgroundColor: primaryColor,
              type: QuickAlertType.success,
            );
          }
        },
        child: BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
          builder: (context, state) {
            return Scaffold(
              resizeToAvoidBottomInset: true,
              appBar: const GeneralAppBar(),
              body: SafeArea(
                child: Column(
                  children: [
                    const LoginHeader(text: 'Forgot the password ?'),
                    const SizedBox(height: 50),
                    Expanded(
                      child: PageView(
                        controller: _pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          EmailCheckPage(
                            formKey: GlobalKey<FormState>(),
                            emailTextFieldController: _emailTextFieldController,
                          ),
                          OtpVerificationPage(
                            formKey: GlobalKey<FormState>(),
                            otpTextFieldController: _otpTextFieldController,
                            email: _emailTextFieldController.text,
                          ),
                          ChangePasswordPage(
                            formKey: GlobalKey<FormState>(),
                            passwordTextFieldController:
                                _passwordTextFieldController,
                            confirmPasswordTextFieldController:
                                _confirmPasswordTextFieldController,
                            email: _emailTextFieldController.text,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
