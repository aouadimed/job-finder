import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:cv_frontend/features/profil/data/models/work_experience_model.dart';
import 'package:cv_frontend/features/profil/presentation/pages/widgets/common_widget/comman_expandable.dart';
import 'package:cv_frontend/global/utils/date_utils.dart';
import 'package:flutter/material.dart';

class WorkExperienceWidget extends StatelessWidget {
  final List<WorkExperiencesModel> experiences;
  final VoidCallback onAddPressed;
  final Function(String) onEditPressed;
  final bool isExpanded;
  final ValueChanged<bool> onExpansionChanged;
  final GlobalKey sectionKey; 

  const WorkExperienceWidget({
    Key? key,
    required this.experiences,
    required this.onAddPressed,
    required this.onEditPressed,
    required this.isExpanded,
    required this.onExpansionChanged, required this.sectionKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonExpandableList<WorkExperiencesModel>(
      iconOnPressed: onAddPressed,
      items: experiences,
      headerTitle: "Work Experience",
      headerIcon: Icons.work,
      editIconOnPressed: onEditPressed,
      itemBuilder: (experience) {
        return Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    experience.jobTitle!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    experience.companyName!,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    getDuration(
                        startDate: experience.startDate!,
                        endDate: experience.endDate),
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.edit, color: primaryColor),
              onPressed: () {
                onEditPressed(experience.id!);
              },
            ),
          ],
        );
      },
      isExpanded: isExpanded,
      onExpansionChanged: onExpansionChanged, sectionKey: sectionKey,
    );
  }
}
