part of 'recruiter_home_bloc.dart';

@immutable
abstract class RecruiterHomeState extends Equatable {
  const RecruiterHomeState();

  @override
  List<Object?> get props => [];
}

class RecruiterHomeInitial extends RecruiterHomeState {}

class RecruiterHomeLoading extends RecruiterHomeState {}

class RecruiterHomeFailure extends RecruiterHomeState {
  final String message;
  final bool? isIntentFailure;

  const RecruiterHomeFailure({
    required this.message,
    this.isIntentFailure,
  });

  @override
  List<Object?> get props => [message, isIntentFailure];
}

class RecruiterHomeSuccess extends RecruiterHomeState {
  final ApplicantModel applicantModel;

  const RecruiterHomeSuccess({required this.applicantModel});

  @override
  List<Object?> get props => [applicantModel];
}
