import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/errors/functions.dart';
import 'package:cv_frontend/features/job_seeker_applications/data/models/job_seeker_application_model.dart';
import 'package:cv_frontend/features/job_seeker_applications/domain/usecases/seeker_application_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'seeker_application_event.dart';
part 'seeker_application_state.dart';

class SeekerApplicationBloc
    extends Bloc<SeekerApplicationsEvent, SeekerApplicationState> {
  final GetSeekerApplcaitionsUsecase getSeekerApplicationsUsecase;

  SeekerApplicationBloc({required this.getSeekerApplicationsUsecase})
      : super(SeekerApplicationInitial()) {
    on<GetSeekerApplicationsEvent>(_onGetSeekerApplicationsEvent);
  }

  Future<void> _onGetSeekerApplicationsEvent(GetSeekerApplicationsEvent event,
      Emitter<SeekerApplicationState> emit) async {
    emit(SeekerApplicationLoading());

    final result = await getSeekerApplicationsUsecase.call(
      GetSeekerApplcaitionsParams(
        page: event.page,
        searchQuery: event.searchQuery,
      ),
    );

    result.fold(
      (failure) => emit(SeekerApplicationFailure(
          message: mapFailureToMessage(failure),
          isIntentFailure: failure is ConnexionFailure)),
      (applications) => emit(SeekerApplicationSuccess(
        jobSeekerApplicationModel: applications,
      )),
    );
  }
}
