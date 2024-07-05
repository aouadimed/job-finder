part of 'language_bloc.dart';

@immutable
abstract class LanguageState extends Equatable {
  const LanguageState();

  @override
  List<Object?> get props => [];
}

class LanguageInitial extends LanguageState {}

class LanguageLoading extends LanguageState {}

class LanguageFailure extends LanguageState {
  final bool isNetworkFailure;
  final String message;

  const LanguageFailure({
    required this.isNetworkFailure,
    required this.message,
  });

  @override
  List<Object?> get props => [isNetworkFailure, message];
}

class CreateLanguageSuccess extends LanguageState {}

class UpdateLanguageSuccess extends LanguageState {}

class DeleteLanguageSuccess extends LanguageState {}

class GetAllLanguagesSuccess extends LanguageState {
  final List<LanguageModel> languages;

  const GetAllLanguagesSuccess({required this.languages});

  @override
  List<Object?> get props => [languages];
}

class GetSingleLanguageSuccess extends LanguageState {
  final LanguageModel language;

  const GetSingleLanguageSuccess({required this.language});

  @override
  List<Object?> get props => [language];
}

class GetSingleLanguageLoading extends LanguageState {}


class GetSingleLanguageFailure extends LanguageState {
  final bool isNetworkFailure;
  final String message;

  const GetSingleLanguageFailure({
    required this.isNetworkFailure,
    required this.message,
  });

  @override
  List<Object?> get props => [isNetworkFailure, message];
}