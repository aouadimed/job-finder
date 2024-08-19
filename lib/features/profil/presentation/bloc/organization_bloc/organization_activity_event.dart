part of 'organization_activity_bloc.dart';

@immutable
abstract class OrganizationActivityEvent extends Equatable {
  const OrganizationActivityEvent();

  @override
  List<Object?> get props => [];
}

class CreateOrganizationActivityEvent extends OrganizationActivityEvent {
  final String organization;
  final String role;
  final String startDate;
  final String endDate;
  final String description;
  final bool stillMember;

  const CreateOrganizationActivityEvent({
    required this.organization,
    required this.role,
    required this.startDate,
    required this.endDate,
    required this.description,
    required this.stillMember,
  });

  @override
  List<Object?> get props => [
        organization,
        role,
        startDate,
        endDate,
        description,
        stillMember,
      ];
}

class GetAllOrganizationActivitiesEvent extends OrganizationActivityEvent {}

class GetSingleOrganizationActivityEvent extends OrganizationActivityEvent {
  final String id;

  const GetSingleOrganizationActivityEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

class UpdateOrganizationActivityEvent extends OrganizationActivityEvent {
  final String id;
  final String organization;
  final String role;
  final String startDate;
  final String endDate;
  final String description;
  final bool stillMember;

  const UpdateOrganizationActivityEvent({
    required this.id,
    required this.organization,
    required this.role,
    required this.startDate,
    required this.endDate,
    required this.description,
    required this.stillMember,
  });

  @override
  List<Object?> get props => [
        id,
        organization,
        role,
        startDate,
        endDate,
        description,
        stillMember,
      ];
}

class DeleteOrganizationActivityEvent extends OrganizationActivityEvent {
  final String id;

  const DeleteOrganizationActivityEvent({required this.id});

  @override
  List<Object?> get props => [id];
}
