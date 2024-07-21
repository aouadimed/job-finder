import 'package:cv_frontend/global/common_widget/big_button.dart';
import 'package:flutter/material.dart';

class ApplyWithProfil extends StatelessWidget {
  final String jobOfferId;
  const ApplyWithProfil({super.key, required this.jobOfferId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BigButton(text: "Submit", onPressed: () {
        print(jobOfferId);
      }),
    );
  }
}
