import 'package:cv_frontend/features/account_setup/presentation/pages/widgets/select_role_widget.dart';
import 'package:cv_frontend/features/authentication/presentation/pages/widgets/header_login.dart';
import 'package:cv_frontend/global/common_widget/app_bar.dart';
import 'package:flutter/material.dart';

class RolePick extends StatefulWidget {
  const RolePick({super.key});

  @override
  State<RolePick> createState() => _RolePickState();
}

class _RolePickState extends State<RolePick> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: GenearalAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: LoginHeader(text: 'Choose Your Job Type', fontSize: 25),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                "Choose whether you are looking for a job or you are an organization/company that needs employees",

                textAlign: TextAlign.center, // Center the text horizontally
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Divider(
                color: Colors.grey, // Adjust line color
                thickness: 0.3, // Adjust line thickness
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: SelectRole(),
                ),
                Expanded(
                  child: SelectRole(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
