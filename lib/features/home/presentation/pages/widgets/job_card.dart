import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:flutter/material.dart';

class JobCard extends StatelessWidget {
  final String companyName;
  final String jobTitle;
  final String location;
  final String jobType;
  final String workType;
  final String companyLogoUrl;
  final VoidCallback onSave;

  const JobCard({
    super.key,
    required this.companyName,
    required this.jobTitle,
    required this.location,
    required this.jobType,
    required this.workType,
    required this.companyLogoUrl,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      margin: const EdgeInsets.all(6.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: whiteColor,
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: Colors.grey.shade400,
                        width: 0.9,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(companyLogoUrl),
                        radius: 30,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          jobTitle,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          companyName,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.bookmark_border),
                    onPressed: onSave,
                  ),
                ],
              ),
              const Divider(),
              Text(
                location,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Chip(
                    label: Text(jobType),
                  ),
                  const SizedBox(width: 8),
                  Chip(
                    label: Text(workType),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
