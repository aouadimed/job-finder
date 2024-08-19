part of 'organization_activity_bloc.dart';

@immutable
abstract class OrganizationActivityState extends Equatable {
  const OrganizationActivityState();

  @override
  List<Object?> get props => [];
}

class OrganizationActivityInitial extends OrganizationActivityState {}

class OrganizationActivityLoading extends OrganizationActivityState {}

class OrganizationActivityFailure extends OrganizationActivityState {
  final bool isNetworkFailure;
  final String message;

  const OrganizationActivityFailure({
    required this.isNetworkFailure,
    required this.message,
  });

  @override
  List<Object?> get props => [isNetworkFailure, message];
}

class CreateOrganizationActivitySuccess extends OrganizationActivityState {}

class UpdateOrganizationActivitySuccess extends OrganizationActivityState {}

class DeleteOrganizationActivitySuccess extends OrganizationActivityState {}

class GetAllOrganizationActivitiesSuccess extends OrganizationActivityState {
  final List<OrganizationActivityModel> activities;

  const GetAllOrganizationActivitiesSuccess({required this.activities});

  @override
  List<Object?> get props => [activities];
}

class GetSingleOrganizationActivitySuccess extends OrganizationActivityState {
  final OrganizationActivityModel activity;

  const GetSingleOrganizationActivitySuccess({required this.activity});

  @override
  List<Object?> get props => [activity];
}

class GetSingleOrganizationActivityLoading extends OrganizationActivityState {}
