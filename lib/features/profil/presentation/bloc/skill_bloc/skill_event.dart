part of 'skill_bloc.dart';

@immutable
abstract class SkillEvent extends Equatable {
  const SkillEvent();

  @override
  List<Object?> get props => [];
}

class CreateSkillEvent extends SkillEvent {
  final String name;

  const CreateSkillEvent({required this.name});

  @override
  List<Object?> get props => [name];
}

class DeleteSkillEvent extends SkillEvent {
  final String id;

  const DeleteSkillEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

class GetSkillsEvent extends SkillEvent {}
