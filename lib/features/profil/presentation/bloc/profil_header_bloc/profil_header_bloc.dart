import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/errors/functions.dart';
import 'package:cv_frontend/features/profil/data/models/profil_header_model.dart';
import 'package:cv_frontend/features/profil/domain/usecases/profil_header_use_cases/get_profil_header_use_case.dart';
import 'package:cv_frontend/features/profil/domain/usecases/profil_header_use_cases/update_profil_header_use_case.dart';
import 'package:cv_frontend/features/profil/domain/usecases/summary_use_cases/get_summary_use_cases.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profil_header_event.dart';
part 'profil_header_state.dart';

class ProfilHeaderBloc extends Bloc<ProfilHeaderEvent, ProfilHeaderState> {
  final GetProfilHeaderUseCase _getProfilHeaderUseCase;
  final UpdateProfilHeaderUsecase _updateProfilHeaderUsecase;

  ProfilHeaderBloc({
    required UpdateProfilHeaderUsecase updateProfilHeaderUsecase,
    required GetProfilHeaderUseCase getProfilHeaderUseCase,
  })  : _getProfilHeaderUseCase = getProfilHeaderUseCase,
        _updateProfilHeaderUsecase = updateProfilHeaderUsecase,
        super(ProfilHeaderInitial()) {
    on<GetProfilHeaderEvent>(_onGetProfilHeaderEvent);
    on<UpdateProfilHeaderEvent>(_onUpdateProfilHeaderEvent);
  }

  Future<void> _onGetProfilHeaderEvent(
      GetProfilHeaderEvent event, Emitter<ProfilHeaderState> emit) async {
    emit(ProfilHeaderLoading());
    final result = await _getProfilHeaderUseCase.call(const NoParams());
    result.fold(
      (failure) => emit(
        ProfilHeaderFailure(
          isIntentFailure: failure.runtimeType == ConnexionFailure,
          message: mapFailureToMessage(failure),
        ),
      ),
      (profileHeader) =>
          emit(GetProfilHeaderSuccess(profileHeader: profileHeader)),
    );
  }

  Future<void> _onUpdateProfilHeaderEvent(
      UpdateProfilHeaderEvent event, Emitter<ProfilHeaderState> emit) async {
    emit(ProfilHeaderLoading());
    final result = await _updateProfilHeaderUsecase.call(
        UpdateProfilHeaderParams(
            deletePhoto: event.deletePhoto,
            firstName: event.firstName,
            lastName: event.lastName,
            profileImg: event.profileImg));
    result.fold(
      (failure) => emit(
        ProfilHeaderFailure(
          isIntentFailure: failure.runtimeType == ConnexionFailure,
          message: mapFailureToMessage(failure),
        ),
      ),
      (_) => emit(EditProfilHeaderSuccess()),
    );
  }
}
