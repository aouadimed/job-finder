import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/errors/functions.dart';
import 'package:cv_frontend/features/profil/data/models/contact_info_model.dart';
import 'package:cv_frontend/features/profil/domain/usecases/contact_info_use_cases/get_contact_info_use_case.dart';
import 'package:cv_frontend/features/profil/domain/usecases/contact_info_use_cases/update_contact_info_use_case.dart';
import 'package:cv_frontend/features/profil/domain/usecases/summary_use_cases/get_summary_use_cases.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'contact_info_event.dart';
part 'contact_info_state.dart';

class ContactInfoBloc extends Bloc<ContactInfoEvent, ContactInfoState> {
  final GetContactInfoUseCase _getContactInfoUseCase;
  final UpdateContactInfoUseCase _updateContactInfoUseCase;

  ContactInfoBloc({
    required GetContactInfoUseCase getContactInfoUseCase,
    required UpdateContactInfoUseCase updateContactInfoUseCase,
  })  : _getContactInfoUseCase = getContactInfoUseCase,
        _updateContactInfoUseCase = updateContactInfoUseCase,
        super(ContactInfoInitial()) {
    on<GetContactInfoEvent>(_onGetContactInfoEvent);
    on<UpdateContactInfoEvent>(_onUpdateContactInfoEvent);
  }

  Future<void> _onGetContactInfoEvent(
      GetContactInfoEvent event, Emitter<ContactInfoState> emit) async {
    emit(ContactInfoLoading());
    final result = await _getContactInfoUseCase.call(const NoParams());
    result.fold(
      (failure) => emit(
        ContactInfoFailure(
          isIntentFailure: failure.runtimeType == ConnexionFailure,
          message: mapFailureToMessage(failure),
        ),
      ),
      (contactInfo) =>
          emit(GetContactInfoSuccess(contactInfoModel: contactInfo)),
    );
  }

  Future<void> _onUpdateContactInfoEvent(
      UpdateContactInfoEvent event, Emitter<ContactInfoState> emit) async {
    emit(ContactInfoLoading());
    final result = await _updateContactInfoUseCase.call(UpdateContactInfoParams(
      address: event.address,
      phone: event.phone,
      email: event.email,
    ));
    result.fold(
      (failure) => emit(
        ContactInfoFailure(
          isIntentFailure: failure.runtimeType == ConnexionFailure,
          message: mapFailureToMessage(failure),
        ),
      ),
      (success) => emit(UpdateContactInfoSuccess()),
    );
  }
}
