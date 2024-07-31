import 'package:cv_frontend/features/recruiter_applications/data/models/job_category_model.dart';
import 'package:cv_frontend/features/recruiter_applications/domain/usecases/job_category_use_cases/get_job_category_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/errors/functions.dart';

part 'job_category_event.dart';
part 'job_category_state.dart';

class JobCategoryBloc extends Bloc<JobCategoryEvent, JobCategoryState> {
  final GetJobCategoryUseCase _getJobCategoryUseCase;

  JobCategoryBloc({required GetJobCategoryUseCase getJobCategoryUseCase})
      : _getJobCategoryUseCase = getJobCategoryUseCase,
        super(JobCategoryInitial()) {
    on<GetJobCategoryEvent>(_onGetJobCategoryEvent);
  }

  Future<void> _onGetJobCategoryEvent(
      GetJobCategoryEvent event, Emitter<JobCategoryState> emit) async {
    emit(JobCategoryLoading());

    final result =
        await _getJobCategoryUseCase.call(GetJobCategoryParams(searchQuery: event.searshQuery));

    result.fold(
      (failure) => emit(JobCategoryFailure(
        isIntentFailure: failure is ConnexionFailure,
        message: mapFailureToMessage(failure),
      )),
      (jobCategories) => emit(JobCategorySuccess(jobCategoryModel: jobCategories)),
    );
  }
}
