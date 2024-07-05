import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/errors/functions.dart';
import 'package:cv_frontend/features/profil/data/models/language_model.dart';
import 'package:cv_frontend/features/profil/domain/usecases/language_use_cases/DeleteLanguageUseCase.dart';
import 'package:cv_frontend/features/profil/domain/usecases/language_use_cases/GetAllLanguagesUseCase.dart';
import 'package:cv_frontend/features/profil/domain/usecases/language_use_cases/GetSingleLanguageUseCase.dart';
import 'package:cv_frontend/features/profil/domain/usecases/language_use_cases/UpdateLanguageUseCase.dart';
import 'package:cv_frontend/features/profil/domain/usecases/language_use_cases/create_language_use_case.dart';
import 'package:cv_frontend/features/profil/domain/usecases/summary_use_cases/get_summary_use_cases.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  final CreateLanguageUseCase _createLanguageUseCase;
  final GetAllLanguagesUseCase _getAllLanguagesUseCase;
  final GetSingleLanguageUseCase _getSingleLanguageUseCase;
  final UpdateLanguageUseCase _updateLanguageUseCase;
  final DeleteLanguageUseCase _deleteLanguageUseCase;

  LanguageBloc({
    required CreateLanguageUseCase createLanguageUseCase,
    required GetAllLanguagesUseCase getAllLanguagesUseCase,
    required GetSingleLanguageUseCase getSingleLanguageUseCase,
    required UpdateLanguageUseCase updateLanguageUseCase,
    required DeleteLanguageUseCase deleteLanguageUseCase,
  })  : _createLanguageUseCase = createLanguageUseCase,
        _getAllLanguagesUseCase = getAllLanguagesUseCase,
        _getSingleLanguageUseCase = getSingleLanguageUseCase,
        _updateLanguageUseCase = updateLanguageUseCase,
        _deleteLanguageUseCase = deleteLanguageUseCase,
        super(LanguageInitial()) {
    on<CreateLanguageEvent>(_onCreateLanguageEvent);
    on<GetAllLanguagesEvent>(_onGetAllLanguagesEvent);
    on<GetSingleLanguageEvent>(_onGetSingleLanguageEvent);
    on<UpdateLanguageEvent>(_onUpdateLanguageEvent);
    on<DeleteLanguageEvent>(_onDeleteLanguageEvent);
  }

  Future<void> _onCreateLanguageEvent(
      CreateLanguageEvent event, Emitter<LanguageState> emit) async {
    emit(LanguageLoading());

    final result = await _createLanguageUseCase.call(
      CreateLanguageParams(
        languageIndex: event.language,
        proficiencyIndex: event.proficiencyIndex,
      ),
    );

    result.fold(
      (failure) => emit(
        LanguageFailure(
          isNetworkFailure: failure.runtimeType == ConnexionFailure,
          message: mapFailureToMessage(failure),
        ),
      ),
      (success) => emit(CreateLanguageSuccess()),
    );
  }

  Future<void> _onGetAllLanguagesEvent(
      GetAllLanguagesEvent event, Emitter<LanguageState> emit) async {
    emit(LanguageLoading());

    final result = await _getAllLanguagesUseCase.call(const NoParams());


    result.fold(
      (failure) => emit(
        LanguageFailure(
          isNetworkFailure: failure.runtimeType == ConnexionFailure,
          message: mapFailureToMessage(failure),
        ),
      ),
      (languages) => emit(GetAllLanguagesSuccess(languages: languages)),
    );
  }

  Future<void> _onGetSingleLanguageEvent(
      GetSingleLanguageEvent event, Emitter<LanguageState> emit) async {
    emit(GetSingleLanguageLoading());

    final result = await _getSingleLanguageUseCase.call(
      GetSingleLanguageParams(id: event.id),
    );

    result.fold(
      (failure) => emit(
        GetSingleLanguageFailure(
          isNetworkFailure: failure.runtimeType == ConnexionFailure,
          message: mapFailureToMessage(failure),
        ),
      ),
      (language) => emit(GetSingleLanguageSuccess(language: language)),
    );
  }

  Future<void> _onUpdateLanguageEvent(
      UpdateLanguageEvent event, Emitter<LanguageState> emit) async {
    emit(LanguageLoading());

    final result = await _updateLanguageUseCase.call(
      UpdateLanguageParams(
        id: event.id,
        languageIndex: event.language,
        proficiencyIndex: event.proficiencyIndex,
      ),
    );

    result.fold(
      (failure) => emit(
        LanguageFailure(
          isNetworkFailure: failure.runtimeType == ConnexionFailure,
          message: mapFailureToMessage(failure),
        ),
      ),
      (success) => emit(UpdateLanguageSuccess()),
    );
  }

  Future<void> _onDeleteLanguageEvent(
      DeleteLanguageEvent event, Emitter<LanguageState> emit) async {
    emit(LanguageLoading());

    final result = await _deleteLanguageUseCase.call(
      DeleteLanguageParams(id: event.id),
    );

    result.fold(
      (failure) => emit(
        LanguageFailure(
          isNetworkFailure: failure.runtimeType == ConnexionFailure,
          message: mapFailureToMessage(failure),
        ),
      ),
      (success) => emit(DeleteLanguageSuccess()),
    );
  }
}
