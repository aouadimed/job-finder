import 'package:cv_frontend/features/profil/data/models/skill_model.dart';
import 'package:cv_frontend/features/profil/presentation/pages/widgets/selection_widgets.dart/skills_chip.dart';
import 'package:cv_frontend/global/common_widget/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class SkillsForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final List<SkillsModel> skills;
  final Function(List<SkillsModel>) onSkillsChanged;
  final Function(SkillsModel) onDeleted;

  const SkillsForm({
    Key? key,
    required this.formKey,
    required this.skills,
    required this.onSkillsChanged,
    required this.onDeleted,
  }) : super(key: key);

  @override
  State<SkillsForm> createState() => _SkillsFormState();
}

class _SkillsFormState extends State<SkillsForm> {
  final TextEditingController _skillController = TextEditingController();
  late List<SkillsModel> _skills;

  @override
  void initState() {
    super.initState();
    _skills = List.from(widget.skills);
  }

  void _addSkill(String skill) {
    if (skill.isNotEmpty && !_skills.any((s) => s.skill == skill)) {
      setState(() {
        SkillsModel newSkill = SkillsModel(id: const Uuid().v4(), skill: skill);
        _skills.add(newSkill);
        _skillController.clear();
        widget.onSkillsChanged(_skills);
      });
    }
  }

  void _removeSkill(SkillsModel skill) {
    setState(() {
      _skills.remove(skill);
      widget.onSkillsChanged(_skills);
    });
    widget.onDeleted(skill);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: widget.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Skills",
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
            const SizedBox(height: 20),
            SkillsChip(
              skills: _skills,
              initialSkills: widget.skills,
              onDeleted: (SkillsModel skill) {
                _removeSkill(skill);
              },
            ),
          ],
        ),
      ),
    );
  }
}
