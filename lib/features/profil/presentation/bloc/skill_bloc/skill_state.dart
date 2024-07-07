part of 'skill_bloc.dart';

@immutable
abstract class SkillState extends Equatable {
  const SkillState();

  @override
  List<Object?> get props => [];
}

class SkillInitial extends SkillState {}

class SkillLoading extends SkillState {}

class SkillFailure extends SkillState {
   final bool isNetworkFailure;
  final String message;

  const SkillFailure({ required this.isNetworkFailure, required this.message});

  @override
  List<Object?> get props => [message];
}

class CreateSkillSuccess extends SkillState {}

class DeleteSkillSuccess extends SkillState {}

class GetSkillsSuccess extends SkillState {
  final List<SkillsModel> skills;

  const GetSkillsSuccess({required this.skills});

  @override
  List<Object?> get props => [skills];
}
