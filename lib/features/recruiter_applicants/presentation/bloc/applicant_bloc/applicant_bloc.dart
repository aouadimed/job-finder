import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/errors/functions.dart';
import 'package:cv_frontend/features/recruiter_applicants/data/models/applicant_model.dart';
import 'package:cv_frontend/features/recruiter_applicants/domain/usecases/get_applicant_list_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'applicant_event.dart';
part 'applicant_state.dart';


class ApplicantBloc extends Bloc<ApplicantEvent, ApplicantState> {
  final GetApplicantsListUseCase getApplicantsListUseCase;

  ApplicantBloc({required this.getApplicantsListUseCase})
      : super(ApplicantInitial()) {
    on<GetApplicantsEvent>(_onGetApplicantsEvent);
  }

  Future<void> _onGetApplicantsEvent(
      GetApplicantsEvent event, Emitter<ApplicantState> emit) async {
    emit(ApplicantLoading());

    final result = await getApplicantsListUseCase.call(
      GetApplicantsListParams(page: event.page!, id: event.id),
    );

    result.fold(
      (failure) => emit(ApplicantFailure(
        message: mapFailureToMessage(failure),
        isIntentFailure: failure is ConnexionFailure,
      )),
      (applicantModel) => emit(ApplicantSuccess(applicantModel: applicantModel)),
    );
  }
}
