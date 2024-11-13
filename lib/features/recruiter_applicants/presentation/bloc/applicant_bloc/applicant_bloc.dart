import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/errors/functions.dart';
import 'package:cv_frontend/features/recruiter_applicants/data/models/applicant_model.dart';
import 'package:cv_frontend/features/recruiter_applicants/domain/usecases/get_applicant_list_use_case.dart';
import 'package:cv_frontend/features/recruiter_applicants/domain/usecases/send_msg_applicant_use_case.dart';
import 'package:cv_frontend/features/recruiter_applicants/domain/usecases/update_applicant_status_use_case.dart';
import 'package:cv_frontend/features/recruiter_applicants/presentation/pages/utils/pdf_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'applicant_event.dart';
part 'applicant_state.dart';

class ApplicantBloc extends Bloc<ApplicantEvent, ApplicantState> {
  final GetApplicantsListUseCase getApplicantsListUseCase;
  final UpdateApplicantUseCase updateApplicantUseCase;
  final PdfService pdfService;
  final SendMessageToApplicantUseCase sendMessageToApplicantUseCase;

  ApplicantBloc({
    required this.getApplicantsListUseCase,
    required this.updateApplicantUseCase,
    required this.pdfService,
    required this.sendMessageToApplicantUseCase,
  }) : super(ApplicantInitial()) {
    on<GetApplicantsEvent>(_onGetApplicantsEvent);
    on<UpdateApplicantStatusEvent>(_onUpdateApplicantStatusEvent);
    on<SendMessageToApplicantEvent>(_onSendMessageToApplicantEvent);
  }

  Future<void> _onGetApplicantsEvent(
      GetApplicantsEvent event, Emitter<ApplicantState> emit) async {
    emit(ApplicantLoading());

    final result = await getApplicantsListUseCase.call(
      GetApplicantsListParams(page: event.page ?? 1, id: event.id),
    );
    await result.fold(
      (failure) async {
        emit(ApplicantFailure(
          message: mapFailureToMessage(failure),
          isIntentFailure: failure is ConnexionFailure,
        ));
      },
      (applicantModel) async {
        final List<Application> updatedApplications = [];
        for (var applicant in applicantModel.application!) {
          if (applicant.useProfile == false) {
            try {
              final pdfPath = await pdfService.loadPdf(applicant.cvUpload!);
              updatedApplications.add(applicant.copyWith(pdfPath: pdfPath));
            } catch (e) {
              updatedApplications.add(applicant);
            }
          } else {
            updatedApplications.add(applicant);
          }
        }
        final updatedModel = applicantModel.copyWith(
          application: updatedApplications,
        );

        if (emit.isDone) return;
        emit(ApplicantSuccess(applicantModel: updatedModel));
      },
    );
  }

  Future<void> _onUpdateApplicantStatusEvent(
      UpdateApplicantStatusEvent event, Emitter<ApplicantState> emit) async {
    emit(ApplicantLoading());

    final result = await updateApplicantUseCase.call(
      UpdateApplicantParams(id: event.id, status: event.status),
    );

    result.fold(
      (failure) => emit(ApplicantFailure(
        message: mapFailureToMessage(failure),
        isIntentFailure: failure is ConnexionFailure,
      )),
      (_) {
        emit(UpdateApplicantSuccess());
      },
    );
  }

  Future<void> _onSendMessageToApplicantEvent(
      SendMessageToApplicantEvent event, Emitter<ApplicantState> emit) async {
    emit(ApplicantLoading());

    final result = await sendMessageToApplicantUseCase.call(
      SendMessageToApplicantParams(id: event.id),
    );

    result.fold(
      (failure) => emit(ApplicantFailure(
        message: mapFailureToMessage(failure),
        isIntentFailure: failure is ConnexionFailure,
      )),
      (_) => emit(UpdateApplicantSuccess()),
    );
  }
}
