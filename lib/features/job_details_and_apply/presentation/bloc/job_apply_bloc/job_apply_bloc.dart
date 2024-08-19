import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/errors/functions.dart';
import 'package:cv_frontend/features/job_details_and_apply/domain/usecases/job_apply_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'job_apply_event.dart';
part 'job_apply_state.dart';

class JobApplyBloc extends Bloc<JobApplyEvent, JobApplyState> {
  final JobApplyUseCase jobApplyUseCase;

  JobApplyBloc({required this.jobApplyUseCase}) : super(JobApplyInitial()) {
    on<SubmitForJobEvent>(_onSubmitForJobEvent);
  }

  Future<void> _onSubmitForJobEvent(
      SubmitForJobEvent event, Emitter<JobApplyState> emit) async {
    emit(JobApplyLoading());

    final result = await jobApplyUseCase.call(JobApplyParams(
      userProfile: event.userProfile,
      cvUpload: event.cvUpload,
      motivationLetter: event.motivationLetter,
      jobId: event.jobId,
    ));

    result.fold(
      (failure) => emit(JobApplyFailure(
          message: mapFailureToMessage(failure),
          isIntentFailure: failure is ConnexionFailure)),
      (_) => emit(JobApplySuccess()),
    );
  }
}
