part of 'summary_bloc.dart';

@immutable
abstract class SummaryState extends Equatable {
  const SummaryState();

  @override
  List<Object?> get props => [];
}

class SummaryInitial extends SummaryState {}

class SummaryLoading extends SummaryState {}

class SummaryFailure extends SummaryState {
  final bool isIntentFailure;
  final String message;

  const SummaryFailure({
    required this.isIntentFailure,
    required this.message,
  });

  @override
  List<Object?> get props => [isIntentFailure, message];
}

class CreateOrUpdateSummarySuccess extends SummaryState {
  final String summaryDescription;

  const CreateOrUpdateSummarySuccess({
    required this.summaryDescription,
  });
}

class GetSummarySuccess extends SummaryState {
  final SummaryModel summaryModel;

  const GetSummarySuccess({required this.summaryModel});

  @override
  List<Object?> get props => [summaryModel];
}


