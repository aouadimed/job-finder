import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/errors/functions.dart';
import 'package:cv_frontend/features/profil/data/models/work_experience_model.dart';
import 'package:cv_frontend/features/profil/domain/usecases/work_experience_use_cases/create_work_experience_use_case.dart';
import 'package:cv_frontend/features/profil/domain/usecases/work_experience_use_cases/delete_work_experince_use_case.dart';
import 'package:cv_frontend/features/profil/domain/usecases/work_experience_use_cases/get_all_work_experience_use_case.dart';
import 'package:cv_frontend/features/profil/domain/usecases/work_experience_use_cases/get_single_work_experiance.dart';
import 'package:cv_frontend/features/profil/domain/usecases/work_experience_use_cases/update_work_experince_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cv_frontend/features/profil/domain/usecases/summary_use_cases/get_summary_use_cases.dart';

part 'work_experience_event.dart';
part 'work_experience_state.dart';

class WorkExperienceBloc
    extends Bloc<WorkExperienceEvent, WorkExperienceState> {
  WorkExperienceBloc({
    required CreateWorkExperienceUseCase createWorkExperienceUseCase,
    required GetAllWorkExperiencesUseCase getAllWorkExperiencesUseCase,
    required GetSingleWorkExperienceUseCase getSingleWorkExperienceUseCase,
    required UpdateWorkExperianceUseCase updateWorkExperienceUseCase,
    required DeleteWorkExperienceUseCase deleteWorkExperienceUseCase,
  })  : _createWorkExperienceUseCase = createWorkExperienceUseCase,
        _getAllWorkExperiencesUseCase = getAllWorkExperiencesUseCase,
        _getSingleWorkExperienceUseCase = getSingleWorkExperienceUseCase,
        _updateWorkExperienceUseCase = updateWorkExperienceUseCase,
        _deleteWorkExperienceUseCase = deleteWorkExperienceUseCase,
        super(WorkExperienceInitial()) {
    on<CreateWorkExperienceEvent>(_onCreateWorkExperienceEvent);
    on<GetAllWorkExperienceEvent>(_onGetAllWorkExperienceEvent);
    on<GetSingleWorkExperienceEvent>(_onGetSingleWorkExperienceEvent);
    on<UpdateWorkExperienceEvent>(_onUpdateWorkExperienceEvent);
    on<DeleteWorkExperienceEvent>(_onDeleteWorkExperienceEvent);
  }

  final CreateWorkExperienceUseCase _createWorkExperienceUseCase;
  final GetAllWorkExperiencesUseCase _getAllWorkExperiencesUseCase;
  final GetSingleWorkExperienceUseCase _getSingleWorkExperienceUseCase;
  final UpdateWorkExperianceUseCase _updateWorkExperienceUseCase;
  final DeleteWorkExperienceUseCase _deleteWorkExperienceUseCase;
  Future<void> _onCreateWorkExperienceEvent(CreateWorkExperienceEvent event,
      Emitter<WorkExperienceState> emit) async {
    emit(WorkExperienceLoading());

    final result = await _createWorkExperienceUseCase.call(
      WorkExperienceParams(
        jobTitle: event.jobTitle,
        companyName: event.companyName,
        employmentType: event.employmentType,
        location: event.location,
        locationType: event.locationType,
        description: event.description,
        startDate: event.startDate,
        endDate: event.endDate,
        ifStillWorking: event.ifStillWorking,
      ),
    );

    result.fold(
      (failure) => emit(
        WorkExperienceFailure(
          isNetworkFailure: failure.runtimeType == ConnexionFailure,
          message: mapFailureToMessage(failure),
        ),
      ),
      (success) => emit(
        CreateWorkExperienceSuccess(
          jobTitle: event.jobTitle,
          companyName: event.companyName,
          employmentType: event.employmentType,
          location: event.location,
          locationType: event.locationType,
          description: event.description,
          startDate: event.startDate,
          endDate: event.endDate,
          ifStillWorking: event.ifStillWorking,
        ),
      ),
    );
  }

  Future<void> _onGetAllWorkExperienceEvent(GetAllWorkExperienceEvent event,
      Emitter<WorkExperienceState> emit) async {
    emit(WorkExperienceLoading());

    final result = await _getAllWorkExperiencesUseCase.call(const NoParams());

    result.fold(
      (failure) => emit(
        WorkExperienceFailure(
          isNetworkFailure: failure.runtimeType == ConnexionFailure,
          message: mapFailureToMessage(failure),
        ),
      ),
      (success) => emit(
        GetAllWorkExperienceSuccess(workExperiencesModel: success),
      ),
    );
  }

  Future<void> _onGetSingleWorkExperienceEvent(
      GetSingleWorkExperienceEvent event,
      Emitter<WorkExperienceState> emit) async {
    emit(GetSingleWorkExperiencLoading());
    final result = await _getSingleWorkExperienceUseCase
        .call(GetSingleWorkExperinceParams(id: event.id));

    result.fold(
      (failure) => emit(
        GetSingleWorkExperiencFailure(
          isNetworkFailure: failure.runtimeType == ConnexionFailure,
          message: mapFailureToMessage(failure),
        ),
      ),
      (success) => emit(
        GetSingleWorkExperienceSuccess(workExperiencesModel: success),
      ),
    );
  }

  Future<void> _onUpdateWorkExperienceEvent(UpdateWorkExperienceEvent event,
      Emitter<WorkExperienceState> emit) async {
    emit(GetSingleWorkExperiencLoading());
    final result =
        await _updateWorkExperienceUseCase.call(UpdateWorkExperianceParams(
      id: event.id,
      jobTitle: event.jobTitle,
      companyName: event.companyName,
      employmentType: event.employmentType,
      location: event.location,
      locationType: event.locationType,
      description: event.description,
      startDate: event.startDate,
      endDate: event.endDate,
      ifStillWorking: event.ifStillWorking,
    ));
    result.fold(
      (failure) => emit(
        WorkExperienceFailure(
          isNetworkFailure: failure.runtimeType == ConnexionFailure,
          message: mapFailureToMessage(failure),
        ),
      ),
      (success) => emit(
        UpdateWorkExperianceSuccess(),
      ),
    );
  }

  Future<void> _onDeleteWorkExperienceEvent(DeleteWorkExperienceEvent event,
      Emitter<WorkExperienceState> emit) async {
    emit(GetSingleWorkExperiencLoading());
    final result = await _deleteWorkExperienceUseCase
        .call(DeleteWorkExperienceParams(id: event.id));

    result.fold(
      (failure) => emit(
        GetSingleWorkExperiencFailure(
          isNetworkFailure: failure.runtimeType == ConnexionFailure,
          message: mapFailureToMessage(failure),
        ),
      ),
      (success) => emit(
        DeleteWorkExperianceSuccess(),
      ),
    );
  }
}
