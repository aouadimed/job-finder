import 'package:cv_frontend/features/job_details_and_apply/presentation/pages/widget/chip_widget.dart';
import 'package:flutter/material.dart';

class VacanciesCard extends StatelessWidget {
  final String categoryName;
  final String jobTitle;
  final List<String> jobDetails;
  final bool isActive;
  final int? applicantsCount;
  final VoidCallback? onTap;
  final VoidCallback? onToggleStatus; 
  final Function() godetails;

  const VacanciesCard({
    Key? key,
    required this.categoryName,
    required this.jobTitle,
    required this.jobDetails,
    required this.isActive,
    this.applicantsCount,
    this.onTap,
    this.onToggleStatus, required this.godetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double textScaleFactor = MediaQuery.of(context).textScaleFactor;
        double titleFontSize = constraints.maxWidth > 600 ? 18 : 16;
        double categoryFontSize = constraints.maxWidth > 600 ? 16 : 14;

        return GestureDetector(
          onTap: onTap,
          child: Container(
            width: constraints.maxWidth,
            margin: const EdgeInsets.all(6.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
                side: BorderSide(width: 1, color: Colors.grey.shade400),
              ),
              color: Colors.white,
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            jobTitle,
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize: titleFontSize * textScaleFactor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.arrow_forward_ios, size: 18),
                          onPressed: godetails,
                        ),
                        GestureDetector(
                          onTap: onToggleStatus, 
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4.0),
                            decoration: BoxDecoration(
                              color: isActive
                                  ? Colors.green.shade100
                                  : Colors.red.shade100,
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Text(
                              isActive ? 'Active' : 'Inactive',
                              style: TextStyle(
                                color: isActive ? Colors.green : Colors.red,
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                        Text(
                      categoryName,
                      style: TextStyle(
                        fontSize: categoryFontSize * textScaleFactor,
                        color: Colors.grey[700],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (applicantsCount != null) ...[
                      const SizedBox(height: 8),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.people, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            '$applicantsCount applicants waiting to be reviewed',
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                    const SizedBox(height: 8),
                    ChipWidget(items: jobDetails),
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
