part of 'company_bloc.dart';

@immutable
abstract class CompanyState extends Equatable {
  const CompanyState();

  @override
  List<Object?> get props => [];
}

class CompanyInitial extends CompanyState {}

class CompanyLoading extends CompanyState {}

class CompanyFailure extends CompanyState {
  final bool isIntentFailure;
  final String message;

  const CompanyFailure({
    required this.isIntentFailure,
    required this.message,
  });

  @override
  List<Object?> get props => [isIntentFailure, message];
}

class CompanySuccess extends CompanyState {}

class CompaniesLoaded extends CompanyState {
  final CompanyProfileModel companies;

  const CompaniesLoaded({required this.companies});

  @override
  List<Object?> get props => [companies];
}
