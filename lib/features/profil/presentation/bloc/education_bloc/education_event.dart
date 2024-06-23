part of 'education_bloc.dart';

@immutable
abstract class EducationEvent extends Equatable {
  const EducationEvent();

  @override
  List<Object?> get props => [];
}

class CreateEducationEvent extends EducationEvent {
  final String school;
  final String? degree;
  final String? fieldOfStudy;
  final String startDate;
  final String endDate;
  final String? grade;
  final String? activitiesAndSocieties;
  final String? description;

  const CreateEducationEvent({
    required this.school,
    this.degree,
    this.fieldOfStudy,
    required this.startDate,
    required this.endDate,
    this.grade,
    this.activitiesAndSocieties,
    this.description,
  });

  @override
  List<Object?> get props => [
        school,
        degree,
        fieldOfStudy,
        startDate,
        endDate,
        grade,
        activitiesAndSocieties,
        description,
      ];
}

class GetAllEducationEvent extends EducationEvent {}

class GetSingleEducationEvent extends EducationEvent {
  final String id;

  const GetSingleEducationEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

class UpdateEducationEvent extends EducationEvent {
  final String id;
  final String school;
  final String? degree;
  final String? fieldOfStudy;
  final String startDate;
  final String endDate;
  final String? grade;
  final String? activitiesAndSocieties;
  final String? description;

  const UpdateEducationEvent({
    required this.id,
    required this.school,
    this.degree,
    this.fieldOfStudy,
    required this.startDate,
    required this.endDate,
    this.grade,
    this.activitiesAndSocieties,
    this.description,
  });

  @override
  List<Object?> get props => [
        id,
        school,
        degree,
        fieldOfStudy,
        startDate,
        endDate,
        grade,
        activitiesAndSocieties,
        description,
      ];
}

class DeleteEducationEvent extends EducationEvent {
  final String id;

  const DeleteEducationEvent({required this.id});

  @override
  List<Object?> get props => [id];
}
