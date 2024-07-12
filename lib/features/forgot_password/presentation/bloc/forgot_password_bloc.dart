import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/errors/functions.dart';
import 'package:cv_frontend/features/forgot_password/domain/usecases/change_password_use_case.dart';
import 'package:cv_frontend/features/forgot_password/domain/usecases/check_email_use_case.dart';
import 'package:cv_frontend/features/forgot_password/domain/usecases/code_verification_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc(
      {required CheckEmailUseCase checkEmailUseCase,
      required CodeVerificationUseCase codeVerificationUseCase,
      required ChangePasswordUseCase changePasswordUseCase})
      : _checkEmailUseCase = checkEmailUseCase,
        _codeVerificationUseCase = codeVerificationUseCase,
        _changePasswordUseCase = changePasswordUseCase,
        super(ForgotPasswordInitial()) {
    on<CheckEmailEvent>(_onCheckEmailEvent);
    on<CodeVerificationEvent>(_codeVerificationEvent);
    on<ChangePasswordEvent>(_onChangePasswordEvent);
  }

  final CheckEmailUseCase _checkEmailUseCase;
  final CodeVerificationUseCase _codeVerificationUseCase;
  final ChangePasswordUseCase _changePasswordUseCase;

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

  Future<void> _codeVerificationEvent(
      CodeVerificationEvent event, Emitter<ForgotPasswordState> emit) async {
    emit(ForgotPasswordLoading());

    final result = await _codeVerificationUseCase.call(
        CodeVerificationParams(email: event.email, resetCode: event.resetCode));

    result.fold(
      (failure) => emit(
        ForgotPasswordFailure(
          isIntentFailure: failure.runtimeType == ConnexionFailure,
          message: mapFailureToMessage(failure),
        ),
      ),
      (success) => emit(
        CodeVerificationSuccess(),
      ),
    );
  }

  Future<void> _onChangePasswordEvent(
      ChangePasswordEvent event, Emitter<ForgotPasswordState> emit) async {
    emit(ForgotPasswordLoading());

    final result = await _changePasswordUseCase.call(ChangePasswordParams(
        email: event.email, newPassword: event.newPassword));

    result.fold(
      (failure) => emit(
        ForgotPasswordFailure(
          isIntentFailure: failure.runtimeType == ConnexionFailure,
          message: mapFailureToMessage(failure),
        ),
      ),
      (success) => emit(
        ChangePasswordSuccess(),
      ),
    );
  }
}
