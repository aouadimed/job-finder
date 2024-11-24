import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/errors/functions.dart';
import 'package:cv_frontend/features/job_seeker_home/data/models/job_card_model.dart';
import 'package:cv_frontend/features/job_seeker_home/domain/usecases/filter_job_offer_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_page_event.dart';
part 'search_page_state.dart';

class SearchPageBloc extends Bloc<SearchPageEvent, SearchPageState> {
  final FilterJobOfferUseCase filterJobOfferUseCase;

  SearchPageBloc({required this.filterJobOfferUseCase}) : super(SearchPageInitial()) {
    on<FilterJobOfferEvent>(_onFilterJobOfferEvent);
  }

  Future<void> _onFilterJobOfferEvent(
      FilterJobOfferEvent event, Emitter<SearchPageState> emit) async {
    emit(SearchPageLoading());
    final result = await filterJobOfferUseCase.call(event.params);

    result.fold(
      (failure) => emit(SearchPageFailure(
          message: mapFailureToMessage(failure),
          isIntentFailure: failure is ConnexionFailure)),
      (jobOffers) => emit(FilterJobOfferSuccess(jobCardModel: jobOffers)),
    );
  }
}
