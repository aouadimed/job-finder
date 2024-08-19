part of 'applicant_bloc.dart';

@immutable
abstract class ApplicantState extends Equatable {
  const ApplicantState();

  @override
  List<Object?> get props => [];
}

class ApplicantInitial extends ApplicantState {}

class ApplicantLoading extends ApplicantState {}

class ApplicantFailure extends ApplicantState {
  final String message;
  final bool isIntentFailure;

  const ApplicantFailure({
    required this.message,
    required this.isIntentFailure,
  });

  @override
  List<Object?> get props => [message, isIntentFailure];
}

class ApplicantSuccess extends ApplicantState {
  final ApplicantModel applicantModel;

  const ApplicantSuccess({required this.applicantModel});

  @override
  List<Object?> get props => [applicantModel];
}
