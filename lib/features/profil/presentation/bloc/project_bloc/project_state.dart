part of 'project_bloc.dart';

@immutable
abstract class ProjectState extends Equatable {
  const ProjectState();

  @override
  List<Object?> get props => [];
}

class ProjectInitial extends ProjectState {}

class ProjectLoading extends ProjectState {}

class ProjectFailure extends ProjectState {
  final bool isNetworkFailure;
  final String message;

  const ProjectFailure({
    required this.isNetworkFailure,
    required this.message,
  });

  @override
  List<Object?> get props => [isNetworkFailure, message];
}

class CreateProjectSuccess extends ProjectState {}

class UpdateProjectSuccess extends ProjectState {}

class DeleteProjectSuccess extends ProjectState {}

class GetAllProjectsSuccess extends ProjectState {
  final List<ProjectsModel> projects;

  const GetAllProjectsSuccess({required this.projects});

  @override
  List<Object?> get props => [projects];
}

class GetSingleProjectSuccess extends ProjectState {
  final ProjectModel project;

  const GetSingleProjectSuccess({required this.project});

  @override
  List<Object?> get props => [project];
}

class GetSingleProjectLoading extends ProjectState {}
