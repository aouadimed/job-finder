import 'dart:async';

import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/errors/functions.dart';
import 'package:cv_frontend/features/authentication/domain/usecases/login_user_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required LoginUserUseCase loginUserUseCase,
  })  : _loginUserUseCase = loginUserUseCase,
        super(AuthInitial()) {
    on<AuthEvent>((event, emit) {});
    on<LoginEvent>(_loginEvent);
  }

  final LoginUserUseCase _loginUserUseCase;

  Future<void> _loginEvent(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final result = await _loginUserUseCase.call(
      LoginUserParams(email: event.email, password: event.password),
    );

    result.fold(
      (failure) => emit(
        LoginFailure(
          isIntentFailure: failure.runtimeType == ConnexionFailure,
          message: mapFailureToMessage(failure),
        ),
      ),
      (success) => emit(LoginSuccess()),
    );
  }
}
