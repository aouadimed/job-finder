import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:cv_frontend/features/profil/data/models/skill_model.dart';
import 'package:cv_frontend/features/profil/presentation/bloc/skill_bloc/skill_bloc.dart';
import 'package:cv_frontend/features/profil/presentation/pages/widgets/common_widget/common_forms_screen.dart';
import 'package:cv_frontend/features/profil/presentation/pages/widgets/forms/skills_form.dart';
import 'package:cv_frontend/global/common_widget/pop_up_msg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SkillsScreen extends StatefulWidget {
  const SkillsScreen({super.key});

  @override
  State<SkillsScreen> createState() => _SkillsScreenState();
}

class _SkillsScreenState extends State<SkillsScreen> {
  final _formKey = GlobalKey<FormState>();
  List<SkillsModel> _initialSkills = [];
  List<SkillsModel> _skills = [];
  List<SkillsModel> _newSkills = [];
  final List<SkillsModel> _deletedSkills = [];

  @override
  void initState() {
    super.initState();
    context.read<SkillBloc>().add(GetSkillsEvent());
  }

  void _updateSkills(List<SkillsModel> skills) {
    setState(() {
      _skills = skills;
      _newSkills = _skills
          .where((skill) => !_initialSkills.any((s) => s.id == skill.id))
          .toList();
    });
  }

  void _saveSkills() {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

    for (var skill in _newSkills) {
      context.read<SkillBloc>().add(CreateSkillEvent(name: skill.skill!));
    }

    for (var skill in _deletedSkills) {
      context.read<SkillBloc>().add(DeleteSkillEvent(id: skill.id!));
    }

    setState(() {
      _newSkills.clear();
      _deletedSkills.clear();
    });
  }

  void _onDeleteSkill(SkillsModel skill) {
    setState(() {
      if (_initialSkills.any((s) => s.id == skill.id)) {
        _deletedSkills.add(skill);
        _initialSkills.removeWhere((s) => s.id == skill.id);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${skill.skill} removed'),
            action: SnackBarAction(
              label: 'UNDO',
              onPressed: () {
                setState(() {
                  _deletedSkills.remove(skill);
                  _initialSkills.add(skill);
                  _skills.add(skill);
                });
              },
            ),
          ),
        );
      }
      _skills.removeWhere((s) => s.id == skill.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SkillBloc, SkillState>(
      listener: (context, state) {
        if (state is GetSkillsSuccess) {
          setState(() {
            _initialSkills = state.skills;
            _skills = List.from(_initialSkills);
          });
        } else if (state is CreateSkillSuccess || state is DeleteSkillSuccess) {
          context.read<SkillBloc>().add(GetSkillsEvent());
        } else if (state is SkillFailure) {
          showSnackBar(
            context: context,
            message: state.message,
            backgroundColor: redColor,
          );
        }
      },
      child: BlocBuilder<SkillBloc, SkillState>(
        builder: (context, state) {
          return CommonFormsScreen(
            isLoading: state is SkillLoading,
            title: "Skills",
            form: Padding(
              padding: const EdgeInsets.all(20),
              child: SkillsForm(
                formKey: _formKey,
                skills: _initialSkills,
                onSkillsChanged: _updateSkills,
                onDeleted: _onDeleteSkill,
              ),
            ),
            onSave: () {
              if (_formKey.currentState!.validate()) {
                _saveSkills();
              }
            },
          );
        },
      ),
    );
  }
}
