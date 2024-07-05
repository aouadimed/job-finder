part of 'project_bloc.dart';

@immutable
abstract class ProjectEvent extends Equatable {
  const ProjectEvent();

  @override
  List<Object?> get props => [];
}

class CreateProjectEvent extends ProjectEvent {
  final String projectName;
  final String? workExperience;
  final String startDate;
  final String endDate;
  final String? description;
  final String? projectUrl;
  final bool ifStillWorkingOnIt;

  const CreateProjectEvent({
    required this.projectName,
    this.workExperience,
    required this.startDate,
    required this.endDate,
    this.description,
    this.projectUrl,
required this.ifStillWorkingOnIt,

  });

  @override
  List<Object?> get props => [
        projectName,
        workExperience,
        startDate,
        endDate,
        description,
        projectUrl,
      ];
}

class GetAllProjectsEvent extends ProjectEvent {}

class GetSingleProjectEvent extends ProjectEvent {
  final String id;

  const GetSingleProjectEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

class UpdateProjectEvent extends ProjectEvent {
  final String id;
  final String projectName;
  final String? workExperience;
  final String startDate;
  final String endDate;
  final String? description;
  final String? projectUrl;
  final bool ifStillWorkingOnIt;

  const UpdateProjectEvent({
    required this.id,
    required this.projectName,
    this.workExperience,
    required this.startDate,
    required this.endDate,
    this.description,
    this.projectUrl,
    required this.ifStillWorkingOnIt,

  });

  @override
  List<Object?> get props => [
        id,
        projectName,
        workExperience,
        startDate,
        endDate,
        description,
        projectUrl,
      ];
}

class DeleteProjectEvent extends ProjectEvent {
  final String id;

  const DeleteProjectEvent({required this.id});

  @override
  List<Object?> get props => [id];
}
