part of 'home_bloc.dart';

@immutable
class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeFailure extends HomeState {
  final String message;
  final bool isIntentFailure;

  const HomeFailure({
    required this.message,
    required this.isIntentFailure,
  });

  @override
  List<Object?> get props => [message, isIntentFailure];
}

class GetJobOfferSuccess extends HomeState {
  final JobCardModel jobCardModel;

  const GetJobOfferSuccess({required this.jobCardModel});

  @override
  List<Object?> get props => [jobCardModel];
}
