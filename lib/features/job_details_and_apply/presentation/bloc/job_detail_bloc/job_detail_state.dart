part of 'job_detail_bloc.dart';

@immutable
class JobDetailState extends Equatable {
  const JobDetailState();

  @override
  List<Object?> get props => [];
}

class JobDetailInitial extends JobDetailState {}

class JobDetailLoading extends JobDetailState {}

class JobDetailFailure extends JobDetailState {
  final String message;
  final bool isIntentFailure;

  const JobDetailFailure({
    required this.message,
    required this.isIntentFailure,
  });

  @override
  List<Object?> get props => [message, isIntentFailure];
}

class JobDetailSuccess extends JobDetailState {
  final JobOfferDetailsModel jobOfferDetailsModel;

  const JobDetailSuccess({required this.jobOfferDetailsModel});

  @override
  List<Object?> get props => [jobOfferDetailsModel];
}

class EditJobSuccess extends JobDetailState {}

class JobEditLoading extends JobDetailState {}

class JobEditFailure extends JobDetailState {
  final String message;
  final bool isIntentFailure;

  const JobEditFailure({
    required this.message,
    required this.isIntentFailure,
  });

  @override
  List<Object?> get props => [message, isIntentFailure];
}



class DeleteJobSuccess extends JobDetailState {}
