part of 'job_offer_bloc.dart';

@immutable
abstract class JobOfferState extends Equatable {
  const JobOfferState();

  @override
  List<Object?> get props => [];
}

class JobOfferInitial extends JobOfferState {}

class JobOfferLoading extends JobOfferState {}

class JobOfferSuccess extends JobOfferState {}

class JobOfferFailure extends JobOfferState {
  final bool isIntentFailure;
  final String message;

  const JobOfferFailure({
    required this.isIntentFailure,
    required this.message,
  });

  @override
  List<Object?> get props => [isIntentFailure, message];
}

class JobOffersLoaded extends JobOfferState {
  final JobOffersModel jobOffersModel;

  const JobOffersLoaded({required this.jobOffersModel});

  @override
  List<Object?> get props => [jobOffersModel];
}
