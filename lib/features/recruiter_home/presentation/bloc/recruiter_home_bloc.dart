import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/errors/functions.dart';
import 'package:cv_frontend/features/recruiter_applicants/data/models/applicant_model.dart';
import 'package:cv_frontend/features/recruiter_applicants/presentation/pages/utils/pdf_service.dart';
import 'package:cv_frontend/features/recruiter_home/domain/usecases/get_recent_applicant_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'recruiter_home_event.dart';
part 'recruiter_home_state.dart';

class RecruiterHomeBloc extends Bloc<RecruiterHomeEvent, RecruiterHomeState> {
  final GetRecentApplicantUseCase getRecentApplicantUseCase;
  final PdfService pdfService;

  RecruiterHomeBloc({
    required this.getRecentApplicantUseCase,
    required this.pdfService,
  }) : super(RecruiterHomeInitial()) {
    on<FetchRecentApplicantsEvent>(_onFetchRecentApplicantsEvent);
  }

  Future<void> _onFetchRecentApplicantsEvent(FetchRecentApplicantsEvent event,
      Emitter<RecruiterHomeState> emit) async {
    emit(RecruiterHomeLoading());

    final result = await getRecentApplicantUseCase(
      GetRecentApplicantParams(
        searshQuery: event.searchQuery,
        page: event.page ?? 1,
      ),
    );

    await result.fold(
      (failure) async {
        emit(RecruiterHomeFailure(
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
        emit(RecruiterHomeSuccess(applicantModel: updatedModel));
      },
    );
  }
}
