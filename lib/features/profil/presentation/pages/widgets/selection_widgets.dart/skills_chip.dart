import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:cv_frontend/features/profil/data/models/skill_model.dart';
import 'package:flutter/material.dart';

class SkillsChip extends StatelessWidget {
  final List<SkillsModel> skills;
  final List<SkillsModel> initialSkills;
  final Function(SkillsModel) onDeleted;

  const SkillsChip({
    Key? key,
    required this.skills,
    required this.initialSkills,
    required this.onDeleted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      verticalDirection: VerticalDirection.up,
      children: skills.map((skill) {
        final bool isOldSkill = initialSkills.any((s) => s.id == skill.id);
        return Chip(
          backgroundColor: whiteColor,
          label: Text(
            skill.skill!,
            style: TextStyle(
              color: isOldSkill ? greyColor : primaryColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          side: BorderSide(
              color: isOldSkill ? greyColor : primaryColor, width: 2),
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
