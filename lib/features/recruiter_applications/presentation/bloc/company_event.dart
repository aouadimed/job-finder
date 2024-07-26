part of 'company_bloc.dart';

@immutable
abstract class CompanyEvent {
  const CompanyEvent();
}

class AddCompanyEvent extends CompanyEvent {
  final CompanyProfileModel companyProfileModel;

  const AddCompanyEvent({required this.companyProfileModel});
}

class GetCompaniesEvent extends CompanyEvent {}
