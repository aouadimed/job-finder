import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:cv_frontend/features/profil/data/models/project_model.dart';
import 'package:cv_frontend/features/profil/presentation/pages/widgets/common_widget/comman_expandable.dart';
import 'package:cv_frontend/global/utils/date_utils.dart';
import 'package:flutter/material.dart';

class ProjectCard extends StatelessWidget {
  final List<ProjectsModel> project;
  final VoidCallback onAddPressed;
  final Function(String) onEditPressed;
  const ProjectCard(
      {super.key,
      required this.onAddPressed,
      required this.onEditPressed,
      required this.project});

  @override
  Widget build(BuildContext context) {
    return CommonExpandableList<ProjectsModel>(
      iconOnPressed: onAddPressed,
      items: project,
      headerTitle: "Projects",
      headerIcon: Icons.poll_rounded,
      editIconOnPressed: onEditPressed,
      itemBuilder: (project) {
        return Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project.projectName!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  (project.workExperience != null)
                      ? Text(
                          project.workExperience!.jobTitle!,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        )
                      : const SizedBox(),
                  Text(
                    getDuration(
                        startDate: project.startDate!,
                        endDate: project.endDate),
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
                onEditPressed(project.id!); // Pass the ID here
              },
            ),
          ],
        );
      },
    );
  }
}
