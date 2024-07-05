import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/errors/functions.dart';
import 'package:cv_frontend/features/profil/data/models/project_model.dart';
import 'package:cv_frontend/features/profil/domain/usecases/project_use_cases/create_project_use_case.dart';
import 'package:cv_frontend/features/profil/domain/usecases/project_use_cases/delete_project_use_case.dart';
import 'package:cv_frontend/features/profil/domain/usecases/project_use_cases/get_all_project_use_case.dart';
import 'package:cv_frontend/features/profil/domain/usecases/project_use_cases/get_single_project_use_case.dart';
import 'package:cv_frontend/features/profil/domain/usecases/project_use_cases/update_project_use_case.dart';
import 'package:cv_frontend/features/profil/domain/usecases/summary_use_cases/get_summary_use_cases.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'project_event.dart';
part 'project_state.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  final CreateProjectUseCase _createProjectUseCase;
  final GetAllProjectsUseCase _getAllProjectsUseCase;
  final GetSingleProjectUseCase _getSingleProjectUseCase;
  final UpdateProjectUseCase _updateProjectUseCase;
  final DeleteProjectUseCase _deleteProjectUseCase;

  ProjectBloc({
    required CreateProjectUseCase createProjectUseCase,
    required GetAllProjectsUseCase getAllProjectsUseCase,
    required GetSingleProjectUseCase getSingleProjectUseCase,
    required UpdateProjectUseCase updateProjectUseCase,
    required DeleteProjectUseCase deleteProjectUseCase,
  })  : _createProjectUseCase = createProjectUseCase,
        _getAllProjectsUseCase = getAllProjectsUseCase,
        _getSingleProjectUseCase = getSingleProjectUseCase,
        _updateProjectUseCase = updateProjectUseCase,
        _deleteProjectUseCase = deleteProjectUseCase,
        super(ProjectInitial()) {
    on<CreateProjectEvent>(_onCreateProjectEvent);
    on<GetAllProjectsEvent>(_onGetAllProjectsEvent);
    on<GetSingleProjectEvent>(_onGetSingleProjectEvent);
    on<UpdateProjectEvent>(_onUpdateProjectEvent);
    on<DeleteProjectEvent>(_onDeleteProjectEvent);
  }

  Future<void> _onCreateProjectEvent(
      CreateProjectEvent event, Emitter<ProjectState> emit) async {
    emit(ProjectLoading());

    final result = await _createProjectUseCase.call(
      CreateProjectParams(
        projectName: event.projectName,
        startDate: event.startDate,
        endDate: event.endDate,
        description: event.description,
        projectUrl: event.projectUrl,
        workExperience: event.workExperience,
        ifStillWorkingOnIt: event.ifStillWorkingOnIt,
      ),
    );

    result.fold(
      (failure) => emit(
        ProjectFailure(
          isNetworkFailure: failure.runtimeType == ConnexionFailure,
          message: mapFailureToMessage(failure),
        ),
      ),
      (success) => emit(CreateProjectSuccess()),
    );
  }

  Future<void> _onGetAllProjectsEvent(
      GetAllProjectsEvent event, Emitter<ProjectState> emit) async {
    emit(ProjectLoading());

    final result = await _getAllProjectsUseCase.call(const NoParams());

    result.fold(
      (failure) => emit(
        ProjectFailure(
          isNetworkFailure: failure.runtimeType == ConnexionFailure,
          message: mapFailureToMessage(failure),
        ),
      ),
      (projects) => emit(GetAllProjectsSuccess(projects: projects)),
    );
  }

  Future<void> _onGetSingleProjectEvent(
      GetSingleProjectEvent event, Emitter<ProjectState> emit) async {
    emit(GetSingleProjectLoading());

    final result = await _getSingleProjectUseCase.call(
      GetSingleProjectParams(id: event.id),
    );

    result.fold(
      (failure) => emit(
        ProjectFailure(
          isNetworkFailure: failure.runtimeType == ConnexionFailure,
          message: mapFailureToMessage(failure),
        ),
      ),
      (project) => emit(GetSingleProjectSuccess(project: project)),
    );
  }

  Future<void> _onUpdateProjectEvent(
      UpdateProjectEvent event, Emitter<ProjectState> emit) async {
    emit(ProjectLoading());

    final result = await _updateProjectUseCase.call(
      UpdateProjectParams(
          id: event.id,
          projectName: event.projectName,
          workExperience: event.workExperience,
          startDate: event.startDate,
          endDate: event.endDate,
          description: event.description,
          projectUrl: event.projectUrl,
          ifStillWorkingOnIt: event.ifStillWorkingOnIt),
    );

    result.fold(
      (failure) => emit(
        ProjectFailure(
          isNetworkFailure: failure.runtimeType == ConnexionFailure,
          message: mapFailureToMessage(failure),
        ),
      ),
      (success) => emit(UpdateProjectSuccess()),
    );
  }

  Future<void> _onDeleteProjectEvent(
      DeleteProjectEvent event, Emitter<ProjectState> emit) async {
    emit(ProjectLoading());

    final result = await _deleteProjectUseCase.call(
      DeleteProjectParams(id: event.id),
    );

    result.fold(
      (failure) => emit(
        ProjectFailure(
          isNetworkFailure: failure.runtimeType == ConnexionFailure,
          message: mapFailureToMessage(failure),
        ),
      ),
      (success) => emit(DeleteProjectSuccess()),
    );
  }
}
