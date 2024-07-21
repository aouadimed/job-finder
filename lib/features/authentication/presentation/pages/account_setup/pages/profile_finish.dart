import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:cv_frontend/core/services/app_routes.dart';
import 'package:cv_frontend/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:cv_frontend/features/authentication/presentation/pages/account_setup/pages/widgets/finish_profile_form.dart';
import 'package:cv_frontend/global/common_widget/app_bar.dart';
import 'package:cv_frontend/global/common_widget/big_button.dart';
import 'package:cv_frontend/global/common_widget/pop_up_msg.dart';
import 'package:cv_frontend/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FinishProfil extends StatefulWidget {


  const FinishProfil({Key? key}) : super(key: key);

  @override
  State<FinishProfil> createState() => _FinishProfilState();
}

class _FinishProfilState extends State<FinishProfil> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _firstnameTextFieldController;
  late TextEditingController _emailTextFieldController;
  late TextEditingController _lastnameTextFieldController;
  late TextEditingController _dobTextFieldController;
  late TextEditingController _numberTextFieldController;
  late TextEditingController _genderController;
  late TextEditingController _usernameTextFieldController;
  late TextEditingController _addressTextFieldController;


  @override
  void initState() {
    _emailTextFieldController = TextEditingController();
    _lastnameTextFieldController = TextEditingController();
    _firstnameTextFieldController = TextEditingController();
    _dobTextFieldController = TextEditingController();
    _numberTextFieldController = TextEditingController();
    _genderController = TextEditingController();
    _usernameTextFieldController = TextEditingController();
    _addressTextFieldController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailTextFieldController.dispose();
    _lastnameTextFieldController.dispose();
    _firstnameTextFieldController.dispose();
    _dobTextFieldController.dispose();
    _numberTextFieldController.dispose();
    _genderController.dispose();
    _usernameTextFieldController.dispose();
    _addressTextFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (args != null) {
      _usernameTextFieldController.text = args['username'] ?? '';
      _emailTextFieldController.text = args['email'] ?? '';
    }

    final String? username = _usernameTextFieldController.text;
    final String? email = _emailTextFieldController.text;
    final String? password = args?['password'];
    final String? selectedcountry = args?['selected_country'];
    final int? selectedrole = args?['selected_role'];
    final List<int>? selectedexpertise = args?['selected_expertise'];

    return BlocProvider(
      create: (context) => sl<AuthBloc>(),
      child: BlocListener<AuthBloc, AuthState>(listener: (context, state) {
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
      }, child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
        return Scaffold(
          appBar: const GeneralAppBar(titleText: "Fill Your Profile"),
          body: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: [
                    ProfilForm(
                      formKey: _formKey,
                      firstnameTextFieldController:
                          _firstnameTextFieldController,
                      usernameTextFieldController:
                          _usernameTextFieldController,
                      emailTextFieldController: _emailTextFieldController,
                      lastnameTextFieldController:
                          _lastnameTextFieldController,
                      dobTextFieldController: _dobTextFieldController,
                      numberTextFieldController: _numberTextFieldController,
                      genderController: _genderController,
                      selectedCountry: selectedcountry,
                      addressTextFieldController: _addressTextFieldController,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Divider(
                        color: Colors.grey,
                        thickness: 0.2,
                      ),
                    ),
                    state is AuthLoading
                        ? const CircularProgressIndicator()
                        : Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: BigButton(
                              text: 'Finish',
                              onPressed: () {
                                handleRegister(
                                    context,
                                    selectedcountry!,
                                    selectedrole!,
                                    selectedexpertise!,
                                    password!);
                              },
                            ),
                          )
                  ],
                ),
              ),
            ),
          ),
        );
      })),
    );
  }

  void handleRegister(BuildContext context, String selectedcountry,
      int selectedroleindex, List<int> selectedexpertise, String password) {
    String selectedRole = (selectedroleindex == 0)
        ? "user"
        : (selectedroleindex == 1)
            ? "admin"
            : "unknown";

    if (_formKey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context).add(RegisterEvent(
          address: _addressTextFieldController.text,
          firstName: _firstnameTextFieldController.text,
          lastName: _lastnameTextFieldController.text,
          dateOfBirth: DateTime.parse(_dobTextFieldController.text),
          phone: _numberTextFieldController.text,
          gender: _genderController.text,
          country: selectedcountry,
          role: selectedRole,
          expertise: selectedexpertise,
          username: _usernameTextFieldController.text,
          email: _emailTextFieldController.text,
          password: password));
    }
  }

    void goBackToLogin(BuildContext context) {
    Navigator.pushReplacementNamed(context,loginScreen);
  }
}
