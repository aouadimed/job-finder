part of "applicant_bloc.dart";

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
  List<Object?> get props => [page];
}
