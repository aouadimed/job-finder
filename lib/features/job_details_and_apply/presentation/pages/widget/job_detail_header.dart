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
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(6.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          side: BorderSide(width: 1, color: Colors.grey.shade400),
        ),
        color: whiteColor,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Center(
                child: Image.network(
                  companyLogoUrl,
                  height: 80,
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  jobTitle,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  companyName,
                  style:  TextStyle(fontSize: 18, color: primaryColor),
                ),
              ),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  location,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 16),
                  Center(
                child: ChipWidget(items: jobDetails),
              ),
              const SizedBox(height: 16),
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
  }
}
