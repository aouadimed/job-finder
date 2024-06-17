part of 'summary_bloc.dart';

@immutable
abstract class SummaryEvent extends Equatable {
  const SummaryEvent();

  @override
  List<Object?> get props => [];
}

class CreateOrUpdateSummaryEvent extends SummaryEvent {
  final String description;

  const CreateOrUpdateSummaryEvent({
    required this.description,
  });

  @override
  List<String?> get props => [description];
}

class GetSummaryEvent extends SummaryEvent {}
