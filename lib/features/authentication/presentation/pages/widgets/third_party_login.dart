import 'package:cv_frontend/features/authentication/presentation/pages/widgets/divider.dart';
import 'package:cv_frontend/features/authentication/presentation/pages/widgets/third_party_login_button.dart';
import 'package:flutter/material.dart';

class ThirdPartyLogin extends StatelessWidget {
  const ThirdPartyLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          DividerAuth(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Btn(
                  path: "assets/images/fb_logo.png",
                  onTap: () {
                    print("facebook");
                  }),
              Btn(
                path: "assets/images/google_logo.webp",
                onTap: () {
                  print("google");
                },
              ),
              Btn(
                path: "assets/images/linkedin_logo.png",
                onTap: () {
                  print("linkedin");
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
