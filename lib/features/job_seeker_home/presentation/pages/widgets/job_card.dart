import 'package:cv_frontend/features/job_details_and_apply/presentation/pages/widget/chip_widget.dart';
import 'package:cv_frontend/global/common_widget/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:cv_frontend/core/constants/appcolors.dart';

class JobCard extends StatelessWidget {
  final String companyName;
  final String jobTitle;
  final String location;
  final String companyLogoUrl;
  final VoidCallback onSave;
  final List<String> items;
  final VoidCallback onTap;
  final bool isSaved;
  final bool? isLoading;

  const JobCard({
    Key? key,
    required this.companyName,
    required this.jobTitle,
    required this.location,
    required this.companyLogoUrl,
    required this.onSave,
    required this.items,
    required this.onTap,
    required this.isSaved,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return InkWell(
          onTap: onTap,
          child: Container(
            width: constraints.maxWidth * 0.95,
            margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
                side: BorderSide(width: 1, color: Colors.grey.shade400),
              ),
              color: whiteColor,
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
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
                                style: TextStyle(
                                  fontSize:
                                      constraints.maxWidth > 350 ? 18 : 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                companyName,
                                style: TextStyle(
                                  fontSize:
                                      constraints.maxWidth > 350 ? 16 : 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        isLoading!
                            ? const LoadingWidget()
                            : IconButton(
                                icon: isSaved
                                    ? Icon(Icons.bookmark, color: primaryColor)
                                    : const Icon(Icons.bookmark_border),
                                onPressed: onSave,
                              ),
                      ],
                    ),
                    const Divider(),
                    Text(
                      location,
                      style: TextStyle(
                        fontSize: constraints.maxWidth > 350 ? 16 : 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        ChipWidget(items: items),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
