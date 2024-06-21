part of 'work_experience_bloc.dart';

@immutable
abstract class WorkExperienceEvent extends Equatable {
  const WorkExperienceEvent();

  @override
  List<Object?> get props => [];
}

class CreateWorkExperienceEvent extends WorkExperienceEvent {
  final String jobTitle;
  final String companyName;
  final int? employmentType;
  final String? location;
  final int? locationType;
  final String? description;
  final String startDate;
  final String? endDate;
  final bool ifStillWorking;
  const CreateWorkExperienceEvent(
      {required this.jobTitle,
      required this.companyName,
      this.employmentType,
      this.location,
      this.locationType,
      this.description,
      required this.startDate,
      this.endDate,
      required this.ifStillWorking});

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
        ifStillWorking
      ];
}

class GetAllWorkExperienceEvent extends WorkExperienceEvent {}

class GetSingleWorkExperienceEvent extends WorkExperienceEvent {
  final String? id;

  const GetSingleWorkExperienceEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

class UpdateWorkExperienceEvent extends WorkExperienceEvent {
  final String id;
  final String jobTitle;
  final String companyName;
  final int? employmentType;
  final String? location;
  final int? locationType;
  final String? description;
  final String startDate;
  final String? endDate;
  final bool ifStillWorking;

  const UpdateWorkExperienceEvent(
      {required this.id,
      required this.jobTitle,
      required this.companyName,
      this.employmentType,
      this.location,
      this.locationType,
      this.description,
      required this.startDate,
      this.endDate,
      required this.ifStillWorking});

  @override
  List<Object?> get props => [
        id,
        jobTitle,
        companyName,
        employmentType,
        location,
        locationType,
        description,
        startDate,
        endDate,
        ifStillWorking
      ];
}



class DeleteWorkExperienceEvent extends WorkExperienceEvent {
  final String id;

  const DeleteWorkExperienceEvent({required this.id});

  @override
  List<Object?> get props => [id];
}