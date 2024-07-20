import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:cv_frontend/features/job_offer/presentation/pages/widgets/skill_chip.dart';
import 'package:cv_frontend/global/common_widget/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:cv_frontend/global/common_widget/common_text_filed.dart';

class JobDescriptionPage extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController minimumQualificationsController;
  final TextEditingController requiredSkillsController;
  final List<String> initialSkills;

  const JobDescriptionPage({
    Key? key,
    required this.formKey,
    required this.minimumQualificationsController,
    required this.requiredSkillsController,
    required this.initialSkills,
  }) : super(key: key);

  @override
  State<JobDescriptionPage> createState() => _JobDescriptionPageState();
}

class _JobDescriptionPageState extends State<JobDescriptionPage> {
  final TextEditingController _skillController = TextEditingController();
  List<String> _skills = [];

  @override
  void initState() {
    super.initState();
    _skills = widget.requiredSkillsController.text
        .split(',')
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();

    for (String skill in widget.initialSkills) {
      if (!_skills.contains(skill)) {
        _skills.add(skill);
      }
    }
  }

  void _addSkill(String skill) {
    if (skill.isNotEmpty && !_skills.contains(skill) && _skills.length < 12) {
      setState(() {
        _skills.add(skill);
        _skillController.clear();
        widget.requiredSkillsController.text = _skills.join(', ');
      });
    }
  }

  void _removeSkill(String skill) {
    setState(() {
      _skills.remove(skill);
      widget.requiredSkillsController.text = _skills.join(', ');
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: widget.formKey,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Required skills",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8.0),
              InputField(
                controller: _skillController,
                hint: "Type here",
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    _addSkill(_skillController.text);
                  },
                ),
                textInputType: TextInputType.text,
                onFieldSubmitted: (value) {
                  _addSkill(value);
                },
              ),
              if (_skills.length >= 12)
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text(
                    "You can only add up to 12 skills.",
                    style: TextStyle(color: redColor),
                  ),
                ),
              const SizedBox(height: 10),
              SkillsChip(
                skills: _skills,
                onDeleted: (String skill) {
                  _removeSkill(skill);
                },
                initialSkills: widget.initialSkills,
              ),
              const SizedBox(height: 8.0),
              CommanInputField(
                controller: widget.minimumQualificationsController,
                title: 'Minimum Qualifications',
                hint: '(Max 500 characters)',
                textInputType: TextInputType.multiline,
                obscureText: false,
                maxLines: 10,
                maxLength: 500,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter your Minimum Qualifications';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
