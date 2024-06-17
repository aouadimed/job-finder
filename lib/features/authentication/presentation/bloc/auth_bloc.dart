import 'dart:async';

import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/errors/functions.dart';
import 'package:cv_frontend/features/authentication/domain/usecases/login_user_use_case.dart';
import 'package:cv_frontend/features/authentication/domain/usecases/sign_up_user_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required LoginUserUseCase loginUserUseCase,
    required SignUpUserUseCase signUpUserUseCase,
  })  : _loginUserUseCase = loginUserUseCase,
        _signUpUserUseCase = signUpUserUseCase,
        super(AuthInitial()) {
    on<AuthEvent>((event, emit) {
      emit(AuthLoading());
    });
    on<LoginEvent>(_loginEvent);
    on<RegisterEvent>(_registerEvent);
  }

  final LoginUserUseCase _loginUserUseCase;
  final SignUpUserUseCase _signUpUserUseCase;

  Future<void> _loginEvent(LoginEvent event, Emitter<AuthState> emit) async {
    final result = await _loginUserUseCase.call(
      LoginUserParams(email: event.email, password: event.password),
    );

    result.fold(
      (failure) => emit(
        AuthFailure(
          isIntentFailure: failure.runtimeType == ConnexionFailure,
          message: mapFailureToMessage(failure),
        ),
      ),
      (success) => emit(LoginSuccess()),
    );
  }

Future<void> _registerEvent(RegisterEvent event, Emitter<AuthState> emit) async {
  try {
    final result = await _signUpUserUseCase.call(
      SignUpUserParams(
        username: event.username,
        email: event.email,
        password: event.password,
        firstName: event.firstName,
        lastName: event.lastName,
        dateOfBirth: event.dateOfBirth,
        phone: event.phone,
        gender: event.gender,
        country: event.country,
        role: event.role,
        expertise: event.expertise,
        profileImg: event.profileImg,
      ),
    );

    result.fold(
      (failure) {
        final isIntentFailure = failure.runtimeType == ConnexionFailure;
        final message = mapFailureToMessage(failure);
        print('Failure: $failure, Intent Failure: $isIntentFailure, Message: $message');
        emit(AuthFailure(isIntentFailure: isIntentFailure, message: message));
      },
      (success) {
        print('Success: $success');
        emit(RegisterSuccess());
      },
    );
  } catch (e) {
    print('Exception: $e');
    emit(AuthFailure(isIntentFailure: false, message: e.toString()));
  }
}
}
