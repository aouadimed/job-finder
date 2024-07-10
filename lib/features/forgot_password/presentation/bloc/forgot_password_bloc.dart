import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/errors/functions.dart';
import 'package:cv_frontend/features/forgot_password/domain/usecases/check_email_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc({
    required CheckEmailUseCase checkEmailUseCase,
  })  : _checkEmailUseCase = checkEmailUseCase,
        super(ForgotPasswordInitial()) {
    on<CheckEmailEvent>(_onCheckEmailEvent);
  }

  final CheckEmailUseCase _checkEmailUseCase;

  Future<void> _onCheckEmailEvent(
      CheckEmailEvent event, Emitter<ForgotPasswordState> emit) async {
    emit(ForgotPasswordLoading());

    final result =
        await _checkEmailUseCase.call(CheckEmailParams(email: event.email));

    result.fold(
      (failure) => emit(
        ForgotPasswordFailure(
          isIntentFailure: failure.runtimeType == ConnexionFailure,
          message: mapFailureToMessage(failure),
        ),
      ),
      (success) => emit(
        ForgotPasswordSuccess(),
      ),
    );
  }
}
