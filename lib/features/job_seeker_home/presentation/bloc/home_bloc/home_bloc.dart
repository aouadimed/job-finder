import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/errors/functions.dart';
import 'package:cv_frontend/features/job_seeker_home/data/models/job_card_model.dart';
import 'package:cv_frontend/features/job_seeker_home/domain/usecases/get_recent_jobs_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetRecentJobsUseCases getRecentJobsUseCases;

  HomeBloc({required this.getRecentJobsUseCases}) : super(HomeInitial()) {
    on<GetRecentJobOffer>(_onGetRecentJobOffer);
  }

  Future<void> _onGetRecentJobOffer(
      GetRecentJobOffer event, Emitter<HomeState> emit) async {
    emit(HomeLoading());

    final result =
        await getRecentJobsUseCases.call(GetRecentJobsParams(page: event.page));

    result.fold(
      (failure) => emit(HomeFailure(
          message: mapFailureToMessage(failure),
          isIntentFailure: failure is ConnexionFailure)),
      (jobOffers) => emit(GetJobOfferSuccess(jobCardModel: jobOffers)),
    );
  }
}
