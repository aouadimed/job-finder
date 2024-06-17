import 'package:cv_frontend/core/services/app_routes.dart';
import 'package:cv_frontend/features/authentication/presentation/pages/account_setup/pages/widgets/expertise_select.dart';
import 'package:cv_frontend/global/common_widget/app_bar.dart';
import 'package:cv_frontend/global/common_widget/big_button.dart';
import 'package:cv_frontend/global/common_widget/pop_up_msg.dart';
import 'package:flutter/material.dart';

class ExpertisePick extends StatefulWidget {
  const ExpertisePick({Key? key}) : super(key: key);

  @override
  State<ExpertisePick> createState() => _ExpertisePickState();
}

class _ExpertisePickState extends State<ExpertisePick> {
  List<int> selectedIndexes = [];
  int? selectedIndex;
  String? username;
  String? email;
  String? password;
  String? selectedcountry;
  int? selectedrole;

  void handleTap(int index) {
    setState(() {
      if (selectedIndexes.contains(index)) {
        selectedIndexes.remove(index);
      } else {
        selectedIndexes.add(index);
      }
    });
  }

  void finshProfil(BuildContext context) {
    Navigator.pushNamed(
      context,
      finishprofil,
      arguments: {
        'username': username,
        'email': email,
        'password': password,
        'selected_country': selectedcountry,
        'selected_role': selectedrole,
        'selected_expertise': selectedIndexes
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
    selectedrole = args?['selected_role'];

    return Scaffold(
      appBar: const GeneralAppBar(),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Text(
                  "What is Your Expertise?",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 15),
                const Text(
                  "Please select your field of expertise (up to 5)",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Divider(
                    color: Colors.grey,
                    thickness: 0.2,
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ExpertiseSelect(
                          text: 'Accounting and Finance',
                          callback: () {
                            handleTap(0);
                          },
                          isSelected: selectedIndexes.contains(0),
                        ),
                        ExpertiseSelect(
                          text: 'Information Technology and software',
                          callback: () {
                            handleTap(1);
                          },
                          isSelected: selectedIndexes.contains(1),
                        ),
                        ExpertiseSelect(
                          text: 'Mangement and consultancy',
                          callback: () {
                            handleTap(2);
                          },
                          isSelected: selectedIndexes.contains(2),
                        ),
                        ExpertiseSelect(
                          text: 'Media, Design, and Creatives',
                          callback: () {
                            handleTap(3);
                          },
                          isSelected: selectedIndexes.contains(3),
                        ),
                        ExpertiseSelect(
                          text: 'Sales and Marketing',
                          callback: () {
                            setState(() {
                              handleTap(4);
                            });
                          },
                          isSelected: selectedIndexes.contains(4),
                        ),
                        ExpertiseSelect(
                          text: 'Writing and Content',
                          callback: () {
                            handleTap(5);
                          },
                          isSelected: selectedIndexes.contains(5),
                        ),
                        ExpertiseSelect(
                          text: 'Architecture and engineering',
                          callback: () {
                            handleTap(6);
                          },
                          isSelected: selectedIndexes.contains(6),
                        ),
                      ],
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Divider(
                    color: Colors.grey,
                    thickness: 0.2,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: BigButton(
                    text: 'Continue',
                    onPressed: () {
                      if (selectedIndexes.isEmpty) {
                        showSnackBar(
                          context: context,
                          message: 'Please select your field of expertise',
                        );
                      } else {
                        finshProfil(context);
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
