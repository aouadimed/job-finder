import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:cv_frontend/features/forgot_password/presentation/bloc/forgot_password_bloc.dart';
import 'package:cv_frontend/global/common_widget/big_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpVerificationPage extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController otpTextFieldController;
  final String email;

  const OtpVerificationPage({
    Key? key,
    required this.formKey,
    required this.otpTextFieldController,
    required this.email,
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
                "Enter verification code",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8.0),
              PinCodeTextField(
                appContext: context,
                autoDisposeControllers : false,
                length: 6,
                obscureText: false,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 50,
                  fieldWidth: 40,
                  activeFillColor: Colors.white,
                  selectedFillColor: Colors.white,
                  inactiveFillColor: Colors.white,
                  inactiveColor: Colors.grey,
                  selectedColor: primaryColor,
                  activeColor: primaryColor,
                ),
                animationDuration: const Duration(milliseconds: 300),
                backgroundColor: Colors.transparent,
                enableActiveFill: true,
                controller: otpTextFieldController,
                onCompleted: (v) {
                    BlocProvider.of<ForgotPasswordBloc>(context).add(
                      CodeVerificationEvent(
                          email: email,
                          resetCode: otpTextFieldController.text),
                    );
                  
                },
                onChanged: (value) {
              //    print(value);
                },
                beforeTextPaste: (text) {
                  return true;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
