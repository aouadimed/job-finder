import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/errors/functions.dart';
import 'package:cv_frontend/features/profil/data/models/education_model.dart';
import 'package:cv_frontend/features/profil/domain/usecases/education_use_cases/create_education_use_case.dart';
import 'package:cv_frontend/features/profil/domain/usecases/education_use_cases/delete_education_use_case.dart';
import 'package:cv_frontend/features/profil/domain/usecases/education_use_cases/get_all_education_use_case.dart';
import 'package:cv_frontend/features/profil/domain/usecases/education_use_cases/get_single_education_use_case.dart';
import 'package:cv_frontend/features/profil/domain/usecases/education_use_cases/update_education_use_case.dart';
import 'package:cv_frontend/features/profil/domain/usecases/summary_use_cases/get_summary_use_cases.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'education_event.dart';
part 'education_state.dart';

class EducationBloc extends Bloc<EducationEvent, EducationState> {
  final CreateEducationUseCase _createEducationUseCase;
  final GetAllEducationsUseCase _getAllEducationsUseCase;
  final GetSingleEducationUseCase _getSingleEducationUseCase;
  final UpdateEducationUseCase _updateEducationUseCase;
  final DeleteEducationUseCase _deleteEducationUseCase;

  EducationBloc({
    required CreateEducationUseCase createEducationUseCase,
    required GetAllEducationsUseCase getAllEducationsUseCase,
    required GetSingleEducationUseCase getSingleEducationUseCase,
    required UpdateEducationUseCase updateEducationUseCase,
    required DeleteEducationUseCase deleteEducationUseCase,
  })  : _createEducationUseCase = createEducationUseCase,
        _getAllEducationsUseCase = getAllEducationsUseCase,
        _getSingleEducationUseCase = getSingleEducationUseCase,
        _updateEducationUseCase = updateEducationUseCase,
        _deleteEducationUseCase = deleteEducationUseCase,
        super(EducationInitial()) {
    on<CreateEducationEvent>(_onCreateEducationEvent);
    on<GetAllEducationEvent>(_onGetAllEducationEvent);
    on<GetSingleEducationEvent>(_onGetSingleEducationEvent);
    on<UpdateEducationEvent>(_onUpdateEducationEvent);
    on<DeleteEducationEvent>(_onDeleteEducationEvent);
  }

  Future<void> _onCreateEducationEvent(
      CreateEducationEvent event, Emitter<EducationState> emit) async {
    emit(EducationLoading());

    final result = await _createEducationUseCase.call(
      CreateEducationUseCaseParams(
        school: event.school,
        degree: event.degree,
        fieldOfStudy: event.fieldOfStudy,
        startDate: event.startDate,
        endDate: event.endDate,
        grade: event.grade,
        activitiesAndSocieties: event.activitiesAndSocieties,
        description: event.description,
      ),
    );

    result.fold(
      (failure) => emit(
        EducationFailure(
          isIntentFailure: failure.runtimeType == ConnexionFailure,
          message: mapFailureToMessage(failure),
        ),
      ),
      (success) => emit(CreateEducationSuccess()),
    );
  }

  Future<void> _onGetAllEducationEvent(
      GetAllEducationEvent event, Emitter<EducationState> emit) async {
    emit(EducationLoading());

    final result = await _getAllEducationsUseCase.call(const NoParams());

    result.fold(
      (failure) => emit(
        EducationFailure(
          isIntentFailure: failure.runtimeType == ConnexionFailure,
          message: mapFailureToMessage(failure),
        ),
      ),
      (educations) => emit(GetAllEducationSuccess(educationsModel: educations)),
    );
  }

  Future<void> _onGetSingleEducationEvent(
      GetSingleEducationEvent event, Emitter<EducationState> emit) async {
    emit(GetSingleEducationLoading());

    final result = await _getSingleEducationUseCase.call(
      GetSingleEducationParams(id: event.id),
    );

    result.fold(
      (failure) => emit(
        GetSingleEducationFailure(
          isNetworkFailure: failure.runtimeType == ConnexionFailure,
          message: mapFailureToMessage(failure),
        ),
      ),
      (education) => emit(GetSingleEducationSuccess(educationModel: education)),
    );
  }

  Future<void> _onUpdateEducationEvent(
      UpdateEducationEvent event, Emitter<EducationState> emit) async {
    emit(EducationLoading());

    final result = await _updateEducationUseCase.call(
      UpdateEducationParams(
        id: event.id,
        school: event.school,
        degree: event.degree,
        fieldOfStudy: event.fieldOfStudy,
        startDate: event.startDate,
        endDate: event.endDate,
        grade: event.grade,
        activitiesAndSocieties: event.activitiesAndSocieties,
        description: event.description,
      ),
    );

    result.fold(
      (failure) => emit(
        EducationFailure(
          isIntentFailure: failure.runtimeType == ConnexionFailure,
          message: mapFailureToMessage(failure),
        ),
      ),
      (success) => emit(UpdateEducationSuccess()),
    );
  }

  Future<void> _onDeleteEducationEvent(
      DeleteEducationEvent event, Emitter<EducationState> emit) async {
    emit(EducationLoading());

    final result = await _deleteEducationUseCase.call(
      DeleteEducationParams(id: event.id),
    );

    result.fold(
      (failure) => emit(
        EducationFailure(
          isIntentFailure: failure.runtimeType == ConnexionFailure,
          message: mapFailureToMessage(failure),
        ),
      ),
      (success) => emit(DeleteEducationSuccess()),
    );
  }
}
