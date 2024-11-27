import 'package:cv_frontend/core/errors/functions.dart';
import 'package:cv_frontend/features/recruiter_applications/data/models/job_offer_model.dart';
import 'package:cv_frontend/features/recruiter_applications/domain/usecases/job_offer_use_cases/add_job_offer_use_cases.dart';
import 'package:cv_frontend/features/recruiter_applications/domain/usecases/job_offer_use_cases/get_list_job_offer_use_cases.dart';
import 'package:cv_frontend/features/recruiter_applications/domain/usecases/job_offer_use_cases/toggle_status_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:cv_frontend/core/errors/failures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'job_offer_event.dart';
part 'job_offer_state.dart';

class JobOfferBloc extends Bloc<JobOfferEvent, JobOfferState> {
  final AddJobOfferUseCase addJobOfferUseCase;
  final GetListJobOfferUseCase getJobOffersUseCase;
  final ToggleStatusUseCase toggleStatusUseCase;

  JobOfferBloc({
    required this.addJobOfferUseCase,
    required this.getJobOffersUseCase,
    required this.toggleStatusUseCase,
  }) : super(JobOfferInitial()) {
    on<AddJobOfferEvent>(_onAddJobOffer);
    on<GetJobOffersEvent>(_onGetJobOffers);
    on<ToggleStatusEvent>(_onToggleStatus);
  }

  Future<void> _onAddJobOffer(
      AddJobOfferEvent event, Emitter<JobOfferState> emit) async {
    emit(JobOfferLoading());

    final result = await addJobOfferUseCase(AddJobOfferParams(
      subcategoryIndex: event.subcategoryIndex,
      employmentTypeIndex: event.employmentTypeIndex,
      locationTypeIndex: event.locationTypeIndex,
      jobDescription: event.jobDescription,
      minimumQualifications: event.minimumQualifications,
      requiredSkills: event.requiredSkills,
      categoryIndex: event.categoryIndex,
    ));

    result.fold(
      (failure) => emit(JobOfferFailure(
        isIntentFailure: failure is ConnexionFailure,
        message: mapFailureToMessage(failure),
      )),
      (_) => emit( JobOfferSuccess()),
    );
  }

  Future<void> _onGetJobOffers(
      GetJobOffersEvent event, Emitter<JobOfferState> emit) async {
    emit(JobOfferLoading());

    final result = await getJobOffersUseCase(
      PageParams(
        page: event.page,
        searchQuery: event.searchQuery,
        filterIndex: event.filterIndex,
      ),
    );

    result.fold(
      (failure) => emit(JobOfferFailure(
        isIntentFailure: failure is ConnexionFailure,
        message: mapFailureToMessage(failure),
      )),
      (jobOffersModel) => emit(JobOffersLoaded(jobOffersModel: jobOffersModel)),
    );
  }

  Future<void> _onToggleStatus(
      ToggleStatusEvent event, Emitter<JobOfferState> emit) async {
    emit(JobOfferLoading());

    final result = await toggleStatusUseCase(ToggleStatusPararms(id: event.id));

    result.fold(
      (failure) => emit(JobOfferFailure(
        isIntentFailure: failure is ConnexionFailure,
        message: mapFailureToMessage(failure),
      )),
      (_) => emit(JobOfferSuccess()),
    );
  }
}
