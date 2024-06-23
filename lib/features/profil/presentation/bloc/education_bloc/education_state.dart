part of 'education_bloc.dart';

@immutable
abstract class EducationState extends Equatable {
  const EducationState();

  @override
  List<Object?> get props => [];
}

class EducationInitial extends EducationState {}

class EducationLoading extends EducationState {}

class EducationFailure extends EducationState {
  final bool isIntentFailure;
  final String message;

  const EducationFailure({
    required this.isIntentFailure,
    required this.message,
  });

  @override
  List<Object?> get props => [isIntentFailure, message];
}

class CreateEducationSuccess extends EducationState {}

class UpdateEducationSuccess extends EducationState {}

class DeleteEducationSuccess extends EducationState {}

class GetAllEducationSuccess extends EducationState {
  final List<EducationsModel> educationsModel;

  const GetAllEducationSuccess({required this.educationsModel});

  @override
  List<Object?> get props => [educationsModel];
}

class GetSingleEducationSuccess extends EducationState {
  final EducationModel educationModel;

  const GetSingleEducationSuccess({required this.educationModel});

  @override
  List<Object?> get props => [educationModel];
}

class GetSingleEducationLoading extends EducationState {}



class GetSingleEducationFailure extends EducationState {
  final bool isNetworkFailure;
  final String message;

  const GetSingleEducationFailure({
    required this.isNetworkFailure,
    required this.message,
  });

  @override
  List<Object?> get props => [isNetworkFailure, message];
}