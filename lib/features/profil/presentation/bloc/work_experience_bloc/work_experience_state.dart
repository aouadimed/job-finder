part of 'work_experience_bloc.dart';

@immutable
abstract class WorkExperienceState extends Equatable {
  const WorkExperienceState();

  @override
  List<Object?> get props => [];
}

class WorkExperienceInitial extends WorkExperienceState {}

class WorkExperienceLoading extends WorkExperienceState {}

class WorkExperienceFailure extends WorkExperienceState {
  final bool isNetworkFailure;
  final String message;

  const WorkExperienceFailure({
    required this.isNetworkFailure,
    required this.message,
  });

  @override
  List<Object?> get props => [isNetworkFailure, message];
}

class CreateWorkExperienceSuccess extends WorkExperienceState {
  final String jobTitle;
  final String companyName;
  final int? employmentType;
  final String? location;
  final int? locationType;
  final String? description;
  final String startDate;
  final String? endDate;
  final bool ifStillWorking;

  const CreateWorkExperienceSuccess({
    required this.jobTitle,
    required this.companyName,
    this.employmentType,
    this.location,
    this.locationType,
    this.description,
    required this.startDate,
    this.endDate,
    required this.ifStillWorking,
  });

  @override
  List<Object?> get props => [
        jobTitle,
        companyName,
        employmentType,
        location,
        locationType,
        description,
        startDate,
        endDate,
        ifStillWorking,
      ];
}

class GetAllWorkExperienceSuccess extends WorkExperienceState {
  final List<WorkExperiencesModel> workExperiencesModel;

  const GetAllWorkExperienceSuccess({required this.workExperiencesModel});

  @override
  List<Object?> get props => [workExperiencesModel];
}

class GetSingleWorkExperienceSuccess extends WorkExperienceState {
  final WorkExperienceModel workExperiencesModel;

  const GetSingleWorkExperienceSuccess({required this.workExperiencesModel});

  @override
  List<Object?> get props => [workExperiencesModel];
}

class GetSingleWorkExperiencFailure extends WorkExperienceState {
  final bool isNetworkFailure;
  final String message;

  const GetSingleWorkExperiencFailure({
    required this.isNetworkFailure,
    required this.message,
  });

  @override
  List<Object?> get props => [isNetworkFailure, message];
}


class GetSingleWorkExperiencLoading extends WorkExperienceState {}

class UpdateWorkExperianceSuccess extends WorkExperienceState {}


class DeleteWorkExperianceSuccess extends WorkExperienceState {}