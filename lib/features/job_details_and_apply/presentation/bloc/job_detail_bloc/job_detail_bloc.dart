import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/errors/functions.dart';
import 'package:cv_frontend/features/job_details_and_apply/data/models/job_offer_details.dart';
import 'package:cv_frontend/features/job_details_and_apply/domain/usecases/get_job_offer_detail_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'job_detail_event.dart';
part 'job_detail_state.dart';



class JobDetailBloc extends Bloc<JobDetailEvent, JobDetailState> {
  final GetJobOfferDetailUseCase getJobOfferDetailUseCase;

  JobDetailBloc({required this.getJobOfferDetailUseCase}) : super(JobDetailInitial()) {
    on<GetJobDetailEvent>(_onGetJobDetailEvent);
  }

  Future<void> _onGetJobDetailEvent(GetJobDetailEvent event, Emitter<JobDetailState> emit) async {
    emit(JobDetailLoading());

    final result = await getJobOfferDetailUseCase.call(GetJobOfferDetailParams(id: event.id));

    result.fold(
      (failure) => emit(JobDetailFailure(
          message: mapFailureToMessage(failure),
          isIntentFailure: failure is ConnexionFailure)),
      (jobOfferDetails) => emit(JobDetailSuccess(jobOfferDetailsModel: jobOfferDetails)),
    );
  }
}
