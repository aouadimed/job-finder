part of 'language_bloc.dart';

@immutable
abstract class LanguageEvent extends Equatable {
  const LanguageEvent();

  @override
  List<Object?> get props => [];
}

class CreateLanguageEvent extends LanguageEvent {
  final int language;
  final int? proficiencyIndex;

  const CreateLanguageEvent({
    required this.language,
     this.proficiencyIndex,
  });

  @override
  List<Object?> get props => [language, proficiencyIndex];
}

class GetAllLanguagesEvent extends LanguageEvent {}

class GetSingleLanguageEvent extends LanguageEvent {
  final String id;

  const GetSingleLanguageEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

class UpdateLanguageEvent extends LanguageEvent {
  final String id;
  final int language;
  final int? proficiencyIndex;

  const UpdateLanguageEvent({
    required this.id,
    required this.language,
   this.proficiencyIndex,
  });

  @override
  List<Object?> get props => [id, language, proficiencyIndex];
}

class DeleteLanguageEvent extends LanguageEvent {
  final String id;

  const DeleteLanguageEvent({required this.id});

  @override
  List<Object?> get props => [id];
}
