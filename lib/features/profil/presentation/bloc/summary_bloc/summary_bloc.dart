import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/errors/functions.dart';
import 'package:cv_frontend/features/profil/data/models/summary_model.dart';
import 'package:cv_frontend/features/profil/domain/usecases/summary_use_cases/create_or_update_sammary_use_case.dart';
import 'package:cv_frontend/features/profil/domain/usecases/summary_use_cases/get_summary_use_cases.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'summary_event.dart';
part 'summary_state.dart';

class SummaryBloc extends Bloc<SummaryEvent, SummaryState> {
  SummaryBloc({
    required CreateOrUpdateSummaryUseCase summaryUseCase,
    required GetSummaryUseCase getSummaryUseCase,
  })  : _summaryUseCase = summaryUseCase,
        _getSummaryUseCase = getSummaryUseCase,
        super(SummaryInitial()) {
    on<CreateOrUpdateSummaryEvent>(_onCreateOrUpdateSummaryEvent);
    on<GetSummaryEvent>(_ongetSummaryUseCase);
  }

  final CreateOrUpdateSummaryUseCase _summaryUseCase;
  final GetSummaryUseCase _getSummaryUseCase;

  Future<void> _onCreateOrUpdateSummaryEvent(
      CreateOrUpdateSummaryEvent event, Emitter<SummaryState> emit) async {
    emit(SummaryLoading());

    final result = await _summaryUseCase.call(
      SummaryParams(description: event.description),
    );

    result.fold(
      (failure) => emit(
        SummaryFailure(
          isIntentFailure: failure.runtimeType == ConnexionFailure,
          message: mapFailureToMessage(failure),
        ),
      ),
      (success) => emit(
        CreateOrUpdateSummarySuccess(
          summaryDescription: event.description,
        ),
      ),
    );
  }

  Future<void> _ongetSummaryUseCase(
      GetSummaryEvent event, Emitter<SummaryState> emit) async {
    emit(SummaryLoading());
    final result = await _getSummaryUseCase.call(const NoParams());
    result.fold(
      (failure) => emit(
        SummaryFailure(
          isIntentFailure: failure.runtimeType == ConnexionFailure,
          message: mapFailureToMessage(failure),
        ),
      ),
      (success) => emit(GetSummarySuccess(summaryModel: success)),
    );
  }
}