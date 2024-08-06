import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/errors/functions.dart';
import 'package:cv_frontend/features/job_seeker_home/domain/usecases/check_saved_job_use_case.dart';
import 'package:cv_frontend/features/job_seeker_home/domain/usecases/remove_saved_job_case.dart';
import 'package:cv_frontend/features/job_seeker_home/domain/usecases/save_job_offer_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'save_job_event.dart';
part 'save_job_state.dart';

class SavedJobBloc extends Bloc<SavedJobEvent, SavedJobState> {
  final CheckSavedJobUseCase checkSavedJobUseCase;
  final SaveJobOfferUseCase saveJobOfferUseCase;
  final RemoveSavedJobUseCase removeSavedJobUseCase;

  SavedJobBloc({
    required this.checkSavedJobUseCase,
    required this.saveJobOfferUseCase,
    required this.removeSavedJobUseCase,
  }) : super(SavedJobInitial()) {
    on<CheckSavedJobEvent>(_onCheckSavedJobEvent);
    on<SaveJobOfferEvent>(_onSaveJobOfferEvent);
    on<RemoveSavedJobEvent>(_onRemoveSavedJobEvent);
  }

  Future<void> _onCheckSavedJobEvent(
      CheckSavedJobEvent event, Emitter<SavedJobState> emit) async {
    emit(SavedJobLoading());

    final result = await checkSavedJobUseCase.call(CheckSavedJobParams(id: event.id));

    result.fold(
      (failure) => emit(SavedJobFailure(
          message: mapFailureToMessage(failure),
          isIntentFailure: failure is ConnexionFailure)),
      (isSaved) => emit(SavedJobCheckSuccess(isSaved: isSaved)),
    );
  }

  Future<void> _onSaveJobOfferEvent(
      SaveJobOfferEvent event, Emitter<SavedJobState> emit) async {
    emit(SavedJobLoading());

    final result = await saveJobOfferUseCase.call(SaveJobOfferParams(id: event.id));

    result.fold(
      (failure) => emit(SavedJobFailure(
          message: mapFailureToMessage(failure),
          isIntentFailure: failure is ConnexionFailure)),
      (isSaved) => emit(SavedJobSaveSuccess(isSaved: isSaved)),
    );
  }

  Future<void> _onRemoveSavedJobEvent(
      RemoveSavedJobEvent event, Emitter<SavedJobState> emit) async {
    emit(SavedJobLoading());

    final result = await removeSavedJobUseCase.call(RemoveSavedJobParams(id: event.id));

    result.fold(
      (failure) => emit(SavedJobFailure(
          message: mapFailureToMessage(failure),
          isIntentFailure: failure is ConnexionFailure)),
      (isSaved) => emit(SavedJobSaveSuccess(isSaved: isSaved)),
    );
  }
}
