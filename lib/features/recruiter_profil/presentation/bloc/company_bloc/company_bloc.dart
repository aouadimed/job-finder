import 'package:cv_frontend/features/recruiter_profil/data/model/company_model.dart';
import 'package:cv_frontend/features/recruiter_profil/domain/usecases/add_update_company_use_case.dart';
import 'package:cv_frontend/features/recruiter_profil/domain/usecases/get_company_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/errors/functions.dart';

part 'company_event.dart';
part 'company_state.dart';

class CompanyBloc extends Bloc<CompanyEvent, CompanyState> {
  final CreateOrUpdateCompanyUseCase _createOrUpdateCompanyUseCase;
  final GetCompaniesUseCase _getCompaniesUseCase;

  CompanyBloc({
    required CreateOrUpdateCompanyUseCase createOrUpdateCompanyUseCase,
    required GetCompaniesUseCase getCompaniesUseCase,
  })  : _createOrUpdateCompanyUseCase = createOrUpdateCompanyUseCase,
        _getCompaniesUseCase = getCompaniesUseCase,
        super(CompanyInitial()) {
    on<AddCompanyEvent>(_onAddCompanyEvent);
    on<GetCompaniesEvent>(_onGetCompaniesEvent);
  }

Future<void> _onAddCompanyEvent(
      AddCompanyEvent event, Emitter<CompanyState> emit) async {
    emit(CompanyLoading());

    final result =
        await _createOrUpdateCompanyUseCase.call(event.companyProfileModel);

    result.fold(
      (failure) => emit(
        CompanyFailure(
          isIntentFailure: failure is ConnexionFailure,
          message: mapFailureToMessage(failure),
        ),
      ),
      (success) => emit(
        CompanySuccess(),
      ),
    );
  }

  

  Future<void> _onGetCompaniesEvent(
      GetCompaniesEvent event, Emitter<CompanyState> emit) async {
    emit(CompanyLoading());
    final result = await _getCompaniesUseCase.call(null);
    result.fold(
      (failure) => emit(
        CompanyFailure(
          isIntentFailure: failure.runtimeType == ConnexionFailure,
          message: mapFailureToMessage(failure),
        ),
      ),
      (companies) => emit(CompaniesLoaded(companies: companies)),
    );
  }
}
