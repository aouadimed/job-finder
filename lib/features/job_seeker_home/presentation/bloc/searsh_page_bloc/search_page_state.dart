part of 'search_page_bloc.dart';

@immutable
abstract class SearchPageState extends Equatable {
  const SearchPageState();

  @override
  List<Object?> get props => [];
}

class SearchPageInitial extends SearchPageState {}

class SearchPageLoading extends SearchPageState {}

class SearchPageFailure extends SearchPageState {
  final String message;
  final bool isIntentFailure;

  const SearchPageFailure({
    required this.message,
    required this.isIntentFailure,
  });

  @override
  List<Object?> get props => [message, isIntentFailure];
}

class FilterJobOfferSuccess extends SearchPageState {
  final JobCardModel jobCardModel;

  const FilterJobOfferSuccess({required this.jobCardModel});

  @override
  List<Object?> get props => [jobCardModel];
}
