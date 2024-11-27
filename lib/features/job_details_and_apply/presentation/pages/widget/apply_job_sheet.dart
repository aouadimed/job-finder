import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:cv_frontend/global/common_widget/big_button.dart';
import 'package:flutter/material.dart';

class JobApplySheet extends StatelessWidget {
  final void Function() onSelectWithCv;
  final void Function() onSelectWithProfil;
  final int completionPercentage;

  const JobApplySheet({
    Key? key,
    required this.onSelectWithCv,
    required this.onSelectWithProfil,
    required this.completionPercentage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isSmallScreen = constraints.maxWidth < 400;

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
                child: isSmallScreen
                    ? Column(
                        children: [
                          BigButton(
                            textColor: primaryColor,
                            color: lightprimaryColor,
                            text: "Apply with CV",
                            onPressed: onSelectWithCv,
                          ),
                          const SizedBox(height: 10),
                          completionPercentage >= 90
                                ? BigButton(
                                    text: "Apply with Profil",
                                    color: primaryColor,
                                    onPressed: onSelectWithProfil,
                                  )
                                : BigButton(
                                    text: "Profil Incomplete",
                                    color: greyColor,
                                    onPressed: null, // Disabled
                                  ),
                        ],
                      )
                    : Row(
                        children: [
                          Expanded(
                            child: BigButton(
                              textColor: primaryColor,
                              color: lightprimaryColor,
                              text: "Apply with CV",
                              onPressed: onSelectWithCv,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: completionPercentage >= 90
                                ? BigButton(
                                    text: "Apply with Profil",
                                    color: primaryColor,
                                    onPressed: onSelectWithProfil,
                                  )
                                : BigButton(
                                    text: "Profil Incomplete",
                                    color: greyColor,
                                    onPressed: null, // Disabled
                                  ),
                          ),
                        ],
                      ),
              )
            ],
          ),
        );
      },
    );
  }
}
