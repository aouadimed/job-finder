import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:cv_frontend/core/services/app_routes.dart';
import 'package:cv_frontend/features/authentication/presentation/pages/account_setup/pages/widgets/select_role_widget.dart';
import 'package:cv_frontend/features/authentication/presentation/pages/widgets/header_login.dart';
import 'package:cv_frontend/global/common_widget/app_bar.dart';
import 'package:cv_frontend/global/common_widget/big_button.dart';
import 'package:flutter/material.dart';

class RolePick extends StatefulWidget {
  const RolePick({super.key});

  @override
  State<RolePick> createState() => _RolePickState();
}

class _RolePickState extends State<RolePick> {
  int selectedIndex = 0;
  String? username;
  String? email;
  String? password;
  String? selectedcountry;

  void handleTap(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void finshProfil(BuildContext context) {
    Navigator.pushNamed(
      context,
      pickexpertive,
      arguments: {
        'username': username,
        'email': email,
        'password': password,
        'selected_country': selectedcountry,
        'selected_role': selectedIndex
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    username = args?['username'];
    email = args?['email'];
    password = args?['password'];
    selectedcountry = args?['selected_country'];
    return Scaffold(
      appBar: const GeneralAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: [
              const Center(
                child: LoginHeader(text: 'Choose Your Job Type', fontSize: 25),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Text(
                  "Choose whether you are looking for a job or you are an organization/company that needs employees",
                  textAlign: TextAlign.center, // Center the text horizontally
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Divider(
                  color: Colors.grey, // Adjust line color
                  thickness: 0.2, // Adjust line thickness
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: SelectRole(
                        iconData: Icons.work_outline_rounded,
                        backgroundColor:
                            const Color.fromRGBO(121, 143, 255, 0.286),
                        iconColor: primaryColor,
                        title: 'Find a Job',
                        description: 'I want to find a job from me',
                        onTap: () {
                          handleTap(0);
                        },
                        isSelected: selectedIndex == 0,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: SelectRole(
                        iconData: Icons.person,
                        backgroundColor:
                            const Color.fromRGBO(255, 158, 44, 0.286),
                        iconColor: const Color.fromRGBO(255, 158, 44, 1),
                        title: 'Find an Employee',
                        description: 'I want to find employees',
                        onTap: () {
                          handleTap(1);
                        },
                        isSelected: selectedIndex == 1,
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Divider(
                  color: Colors.grey, // Adjust line color
                  thickness: 0.2, // Adjust line thickness
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: BigButton(
                  text: 'Continue',
                  onPressed: () {
                   finshProfil(context);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
