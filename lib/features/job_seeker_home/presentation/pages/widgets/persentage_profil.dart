import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ProfileCompletionWidget extends StatelessWidget {
  final int completionPercentage;

  const ProfileCompletionWidget({Key? key, required this.completionPercentage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.04),
      child: Container(
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(30),
        ),
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: Row(
          children: [
            CircularPercentIndicator(
              radius: screenWidth * 0.15,
              lineWidth: screenWidth * 0.02,
              percent: completionPercentage / 100,
              center: Text(
                "$completionPercentage%",
                style: TextStyle(
                  fontSize: screenWidth * 0.05,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              progressColor: Colors.white,
              backgroundColor: lightprimaryColor.withOpacity(0.4),
              circularStrokeCap: CircularStrokeCap.round,
            ),
            SizedBox(width: screenWidth * 0.05),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Profile Completed!",
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: screenWidth * 0.01),
                  Text(
                    "A complete profile increases the\nchances of a recruiter being more\ninterested in recruiting you.",
                    style: TextStyle(
                      fontSize: screenWidth * 0.03,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
