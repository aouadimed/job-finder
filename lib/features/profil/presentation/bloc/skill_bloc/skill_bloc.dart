import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/errors/functions.dart';
import 'package:cv_frontend/features/profil/data/models/skill_model.dart';
import 'package:cv_frontend/features/profil/domain/usecases/skill_use_cases/create_skill_use_case.dart';
import 'package:cv_frontend/features/profil/domain/usecases/skill_use_cases/delete_skill_use_case.dart';
import 'package:cv_frontend/features/profil/domain/usecases/skill_use_cases/get_skill_use_case.dart';
import 'package:cv_frontend/features/profil/domain/usecases/summary_use_cases/get_summary_use_cases.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'skill_event.dart';
part 'skill_state.dart';

class SkillBloc extends Bloc<SkillEvent, SkillState> {
  final CreateSkillUseCase createSkillUseCase;
  final DeleteSkillUseCase deleteSkillUseCase;
  final GetSkillsUseCase getSkillsUseCase;

  SkillBloc({
    required this.createSkillUseCase,
    required this.deleteSkillUseCase,
    required this.getSkillsUseCase,
  }) : super(SkillInitial()) {
    on<CreateSkillEvent>(_onCreateSkillEvent);
    on<DeleteSkillEvent>(_onDeleteSkillEvent);
    on<GetSkillsEvent>(_onGetSkillsEvent);
  }

  Future<void> _onCreateSkillEvent(
      CreateSkillEvent event, Emitter<SkillState> emit) async {
    emit(SkillLoading());

    final result = await createSkillUseCase.call(
      CreateSkillParams(name: event.name),
    );

    result.fold(
      (failure) => emit(SkillFailure(
          message: mapFailureToMessage(failure),
          isNetworkFailure: failure.runtimeType == ConnexionFailure)),
      (success) => emit(CreateSkillSuccess()),
    );
  }

  Future<void> _onDeleteSkillEvent(
      DeleteSkillEvent event, Emitter<SkillState> emit) async {
    emit(SkillLoading());

    final result = await deleteSkillUseCase.call(
      DeleteSkillParams(id: event.id),
    );

    result.fold(
      (failure) => emit(SkillFailure(
          message: mapFailureToMessage(failure),
          isNetworkFailure: failure.runtimeType == ConnexionFailure)),
      (success) => emit(DeleteSkillSuccess()),
    );
  }

  Future<void> _onGetSkillsEvent(
      GetSkillsEvent event, Emitter<SkillState> emit) async {
    emit(SkillLoading());

    final result = await getSkillsUseCase.call(const NoParams());

    result.fold(
      (failure) => emit(SkillFailure(
          message: mapFailureToMessage(failure),
          isNetworkFailure: failure.runtimeType == ConnexionFailure)),
      (skills) => emit(GetSkillsSuccess(skills: skills)),
    );
  }
}
