import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/errors/functions.dart';
import 'package:cv_frontend/features/job_seeker_home/data/models/profil_percentage_model.dart';
import 'package:cv_frontend/features/job_seeker_home/domain/usecases/get_profil_percentage.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profil_percentage_event.dart';
part 'profil_percentage_state.dart';

class ProfilPercentageBloc extends Bloc<ProfilPercentageEvent, ProfilPercentageState> {
  final ProfilPercentageUseCase profilPercentageUseCase;

  ProfilPercentageBloc({required this.profilPercentageUseCase}) : super(ProfilPercentageInitial()) {
    on<GetProfilPercentageEvent>(_onGetProfilPercentageEvent);
  }

  Future<void> _onGetProfilPercentageEvent(
      GetProfilPercentageEvent event, Emitter<ProfilPercentageState> emit) async {
    emit(ProfilPercentageLoading());
    
    final result = await profilPercentageUseCase.call(null);

    result.fold(
      (failure) => emit(ProfilPercentageFailure(
        message: mapFailureToMessage(failure),
        isIntentFailure: failure is ConnexionFailure,
      )),
      (completionPercentage) => emit(ProfilPercentageSuccess(completionPercentage: completionPercentage)),
    );
  }
}
