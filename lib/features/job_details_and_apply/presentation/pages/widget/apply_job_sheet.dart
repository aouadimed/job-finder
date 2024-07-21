import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:cv_frontend/global/common_widget/big_button.dart';
import 'package:flutter/material.dart';

class JobApplySheet extends StatelessWidget {
  final void Function() onSelectWithCv;
  final void Function() onSelectWithProfil;

  const JobApplySheet({
    Key? key,
    required this.onSelectWithCv,
    required this.onSelectWithProfil,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            width: 80,
            height: 8,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Center(
              child: Text(
                "Apply For Job",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(10),
            child: Divider(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                    child: BigButton(
                        textColor: primaryColor,
                        color: lightprimaryColor,
                        text: "Apply with CV",
                        onPressed: onSelectWithCv)),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: BigButton(
                        text: "Apply with Profil",
                        onPressed: onSelectWithProfil)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
