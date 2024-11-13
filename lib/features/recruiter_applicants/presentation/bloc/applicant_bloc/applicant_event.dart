part of 'applicant_bloc.dart';

@immutable
class ApplicantEvent extends Equatable {
  const ApplicantEvent();

  @override
  List<Object?> get props => [];
}

class GetApplicantsEvent extends ApplicantEvent {
  final String id;
  final int? page;

  const GetApplicantsEvent({required this.id, this.page});

  @override
  List<Object?> get props => [id, page];
}

class UpdateApplicantStatusEvent extends ApplicantEvent {
  final String id;
  final String status;

  const UpdateApplicantStatusEvent({required this.id, required this.status});

  @override
  List<Object?> get props => [id, status];
}


class SendMessageToApplicantEvent extends ApplicantEvent {
  final String id;

  const SendMessageToApplicantEvent({required this.id});

  @override
  List<Object?> get props => [id];
}
