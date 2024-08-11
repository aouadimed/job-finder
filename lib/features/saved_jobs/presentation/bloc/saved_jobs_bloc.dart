import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/errors/functions.dart';
import 'package:cv_frontend/features/job_seeker_home/domain/usecases/remove_saved_job_case.dart';
import 'package:cv_frontend/features/saved_jobs/data/models/saved_jobs_model.dart';
import 'package:cv_frontend/features/saved_jobs/domain/usecases/get_saved_jobs_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'saved_jobs_event.dart';
part 'saved_jobs_state.dart';

class SavedJobsBloc extends Bloc<SavedJobsEvent, SavedJobsState> {
  final GetSavedJobsUsecase getSavedJobsUsecase;
  final RemoveSavedJobUseCase removeSavedJobUseCase;

  SavedJobsBloc({
    required this.getSavedJobsUsecase,
    required this.removeSavedJobUseCase,
  }) : super(SavedJobsInitial()) {
    on<GetSavedJobsEvent>(_onGetSavedJobsEvent);
    on<RemoveSavedJobsEvent>(_onRemoveSavedJobEvent);
  }

  Future<void> _onGetSavedJobsEvent(
      GetSavedJobsEvent event, Emitter<SavedJobsState> emit) async {
    emit(SavedJobsLoading());

    final result = await getSavedJobsUsecase.call(
      GetSavedJobsParams(page: event.page, searchQuery: event.searchQuery),
    );

    result.fold(
      (failure) => emit(SavedJobsFailure(
          message: mapFailureToMessage(failure),
          isIntentFailure: failure is ConnexionFailure)),
      (savedJobs) => emit(SavedJobsSuccess(savedJobsModel: savedJobs)),
    );
  }

  Future<void> _onRemoveSavedJobEvent(
      RemoveSavedJobsEvent event, Emitter<SavedJobsState> emit) async {
    emit(SavedJobsLoading());

    final result = await removeSavedJobUseCase.call(
      RemoveSavedJobParams(id: event.id),
    );

    result.fold(
      (failure) => emit(SavedJobsFailure(
          message: mapFailureToMessage(failure),
          isIntentFailure: failure is ConnexionFailure)),
      (success) {
        if (success) {
          if (state is SavedJobsSuccess) {
            final updatedJobs = (state as SavedJobsSuccess)
                .savedJobsModel
                .savedJobs!
                .where((job) => job.id != event.id)
                .toList();

            emit(SavedJobsSuccess(
              savedJobsModel: SavedJobsModel(
                savedJobs: updatedJobs,
                totalPages:
                    (state as SavedJobsSuccess).savedJobsModel.totalPages,
                currentPage:
                    (state as SavedJobsSuccess).savedJobsModel.currentPage,
              ),
            ));
          }
        }
      },
    );
  }
}
