import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:cv_frontend/features/profil/data/models/education_model.dart';
import 'package:cv_frontend/features/profil/presentation/pages/widgets/common_widget/comman_expandable.dart';
import 'package:flutter/material.dart';

class EducationWidget extends StatelessWidget {
  final List<EducationsModel> education;
  final VoidCallback onAddPressed;
  final Function(String) onEditPressed;

  const EducationWidget({
    Key? key,
    required this.education,
    required this.onAddPressed,
    required this.onEditPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonExpandableList<EducationsModel>(
      iconOnPressed: onAddPressed,
      items: education,
      headerTitle: "Education",
      headerIcon: Icons.school,
      editIconOnPressed: onEditPressed,
      itemBuilder: (edu) {
        return Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    edu.fieldOfStudy!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    edu.school!,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    edu.getDuration(),
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
                onEditPressed(edu.id!); // Pass the ID here
              },
            ),
          ],
        );
      },
    );
  }
}
