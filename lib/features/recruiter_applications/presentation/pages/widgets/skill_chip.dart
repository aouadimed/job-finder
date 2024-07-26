import 'package:flutter/material.dart';
import 'package:cv_frontend/core/constants/appcolors.dart';

class SkillsChip extends StatelessWidget {
  final List<String> skills;
  final List<String> initialSkills;
  final Function(String) onDeleted;

  const SkillsChip({
    Key? key,
    required this.skills,
    required this.initialSkills,
    required this.onDeleted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      verticalDirection: VerticalDirection.up,
      spacing: 8.0,
      runSpacing: 4.0,
      children: skills.map((skill) {
        final bool isOldSkill = initialSkills.contains(skill);
        return Chip(
          backgroundColor: whiteColor,
          label: Text(
            skill,
            style: TextStyle(
              color: isOldSkill ? greyColor : primaryColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          side: BorderSide(color: isOldSkill ? greyColor : primaryColor, width: 2),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          deleteIcon: Icon(
            Icons.close,
            color: isOldSkill ? greyColor : primaryColor,
            size: 18,
          ),
          onDeleted: () => onDeleted(skill),
        );
      }).toList(),
    );
  }
}
