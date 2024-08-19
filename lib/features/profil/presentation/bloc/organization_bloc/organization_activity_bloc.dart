import 'package:cv_frontend/core/errors/functions.dart';
import 'package:cv_frontend/features/profil/domain/usecases/organization_use_cases/organization_use_cases.dart';
import 'package:cv_frontend/features/profil/domain/usecases/summary_use_cases/get_summary_use_cases.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/features/profil/data/models/organization_activity_model.dart';

part 'organization_activity_event.dart';
part 'organization_activity_state.dart';

class OrganizationActivityBloc
    extends Bloc<OrganizationActivityEvent, OrganizationActivityState> {
  final CreateOrganizationActivityUseCase _createOrganizationActivityUseCase;
  final GetAllOrganizationActivitiesUseCase
      _getAllOrganizationActivitiesUseCase;
  final GetSingleOrganizationActivityUseCase
      _getSingleOrganizationActivityUseCase;
  final UpdateOrganizationActivityUseCase _updateOrganizationActivityUseCase;
  final DeleteOrganizationActivityUseCase _deleteOrganizationActivityUseCase;

  OrganizationActivityBloc({
    required CreateOrganizationActivityUseCase
        createOrganizationActivityUseCase,
    required GetAllOrganizationActivitiesUseCase
        getAllOrganizationActivitiesUseCase,
    required GetSingleOrganizationActivityUseCase
        getSingleOrganizationActivityUseCase,
    required UpdateOrganizationActivityUseCase
        updateOrganizationActivityUseCase,
    required DeleteOrganizationActivityUseCase
        deleteOrganizationActivityUseCase,
  })  : _createOrganizationActivityUseCase = createOrganizationActivityUseCase,
        _getAllOrganizationActivitiesUseCase =
            getAllOrganizationActivitiesUseCase,
        _getSingleOrganizationActivityUseCase =
            getSingleOrganizationActivityUseCase,
        _updateOrganizationActivityUseCase = updateOrganizationActivityUseCase,
        _deleteOrganizationActivityUseCase = deleteOrganizationActivityUseCase,
        super(OrganizationActivityInitial()) {
    on<CreateOrganizationActivityEvent>(_onCreateOrganizationActivityEvent);
    on<GetAllOrganizationActivitiesEvent>(_onGetAllOrganizationActivitiesEvent);
    on<GetSingleOrganizationActivityEvent>(
        _onGetSingleOrganizationActivityEvent);
    on<UpdateOrganizationActivityEvent>(_onUpdateOrganizationActivityEvent);
    on<DeleteOrganizationActivityEvent>(_onDeleteOrganizationActivityEvent);
  }

  Future<void> _onCreateOrganizationActivityEvent(
      CreateOrganizationActivityEvent event,
      Emitter<OrganizationActivityState> emit) async {
    emit(OrganizationActivityLoading());

    final result = await _createOrganizationActivityUseCase.call(
      CreateOrganizationActivityParams(
        organization: event.organization,
        role: event.role,
        startDate: event.startDate,
        endDate: event.endDate,
        description: event.description,
        stillMember: event.stillMember,
      ),
    );

    result.fold(
      (failure) => emit(
        OrganizationActivityFailure(
          isNetworkFailure: failure.runtimeType == ConnexionFailure,
          message: mapFailureToMessage(failure),
        ),
      ),
      (success) => emit(CreateOrganizationActivitySuccess()),
    );
  }

  Future<void> _onGetAllOrganizationActivitiesEvent(
      GetAllOrganizationActivitiesEvent event,
      Emitter<OrganizationActivityState> emit) async {
    emit(OrganizationActivityLoading());

    final result = await _getAllOrganizationActivitiesUseCase.call(const NoParams());

    result.fold(
      (failure) => emit(
        OrganizationActivityFailure(
          isNetworkFailure: failure.runtimeType == ConnexionFailure,
          message: mapFailureToMessage(failure),
        ),
      ),
      (activities) =>
          emit(GetAllOrganizationActivitiesSuccess(activities: activities)),
    );
  }

  Future<void> _onGetSingleOrganizationActivityEvent(
      GetSingleOrganizationActivityEvent event,
      Emitter<OrganizationActivityState> emit) async {
    emit(GetSingleOrganizationActivityLoading());

    final result = await _getSingleOrganizationActivityUseCase.call(
      GetSingleOrganizationActivityParams(id: event.id),
    );

    result.fold(
      (failure) => emit(
        OrganizationActivityFailure(
          isNetworkFailure: failure.runtimeType == ConnexionFailure,
          message: mapFailureToMessage(failure),
        ),
      ),
      (activity) =>
          emit(GetSingleOrganizationActivitySuccess(activity: activity)),
    );
  }

  Future<void> _onUpdateOrganizationActivityEvent(
      UpdateOrganizationActivityEvent event,
      Emitter<OrganizationActivityState> emit) async {
    emit(OrganizationActivityLoading());

    final result = await _updateOrganizationActivityUseCase.call(
      UpdateOrganizationActivityParams(
        id: event.id,
        organization: event.organization,
        role: event.role,
        startDate: event.startDate,
        endDate: event.endDate,
        description: event.description,
        stillMember: event.stillMember,
      ),
    );

    result.fold(
      (failure) => emit(
        OrganizationActivityFailure(
          isNetworkFailure: failure.runtimeType == ConnexionFailure,
          message: mapFailureToMessage(failure),
        ),
      ),
      (success) => emit(UpdateOrganizationActivitySuccess()),
    );
  }

  Future<void> _onDeleteOrganizationActivityEvent(
      DeleteOrganizationActivityEvent event,
      Emitter<OrganizationActivityState> emit) async {
    emit(OrganizationActivityLoading());

    final result = await _deleteOrganizationActivityUseCase.call(
      DeleteOrganizationActivityParams(id: event.id),
    );

    result.fold(
      (failure) => emit(
        OrganizationActivityFailure(
          isNetworkFailure: failure.runtimeType == ConnexionFailure,
          message: mapFailureToMessage(failure),
        ),
      ),
      (success) => emit(DeleteOrganizationActivitySuccess()),
    );
  }
}
