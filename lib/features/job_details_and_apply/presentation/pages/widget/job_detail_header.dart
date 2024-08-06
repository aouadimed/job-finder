import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:cv_frontend/features/job_details_and_apply/presentation/pages/widget/chip_widget.dart';
import 'package:flutter/material.dart';

class JobCard extends StatelessWidget {
  final String companyName;
  final String jobTitle;
  final String location;
  final List<String> jobDetails;
  final String companyLogoUrl;
  final String postDate;

  const JobCard({
    super.key,
    required this.companyName,
    required this.jobTitle,
    required this.location,
    required this.jobDetails,
    required this.companyLogoUrl,
    required this.postDate,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isTablet = constraints.maxWidth > 600;
        final double padding = isTablet ? 32.0 : 16.0;
        final double avatarSize = isTablet ? 150.0 : 100.0;
        final double fontSizeTitle = isTablet ? 28.0 : 20.0;
        final double fontSizeSubtitle = isTablet ? 20.0 : 16.0;

        return Container(
          width: double.infinity,
          margin: const EdgeInsets.all(6.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40.0),
              side: BorderSide(width: 1, color: Colors.grey.shade400),
            ),
            color: whiteColor,
            elevation: 0,
            child: Padding(
              padding: EdgeInsets.all(padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: padding),
                  Center(
                    child: Container(
                      width: avatarSize,
                      height: avatarSize,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Colors.grey.shade400,
                          width: 0.9,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(padding / 4),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(companyLogoUrl),
                          radius: avatarSize / 2,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: padding),
                  Center(
                    child: Text(
                      jobTitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: fontSizeTitle,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: padding / 2),
                  Center(
                    child: Text(
                      companyName,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: fontSizeSubtitle,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  SizedBox(height: padding),
                  const Divider(thickness: 0.3),
                  SizedBox(height: padding),
                  Center(
                    child: Text(
                      location,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: fontSizeSubtitle),
                    ),
                  ),
                  SizedBox(height: padding),
                  Center(
                    child: ChipWidget(items: jobDetails),
                  ),
                  SizedBox(height: padding),
                  Center(
                    child: Text(
                      postDate,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
