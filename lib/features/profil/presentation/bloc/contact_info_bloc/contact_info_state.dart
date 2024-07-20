part of 'contact_info_bloc.dart';

@immutable
abstract class ContactInfoState extends Equatable {
  const ContactInfoState();

  @override
  List<Object?> get props => [];
}

class ContactInfoInitial extends ContactInfoState {}

class ContactInfoLoading extends ContactInfoState {}

class ContactInfoFailure extends ContactInfoState {
  final bool isIntentFailure;
  final String message;

  const ContactInfoFailure({
    required this.isIntentFailure,
    required this.message,
  });

  @override
  List<Object?> get props => [isIntentFailure, message];
}

class GetContactInfoSuccess extends ContactInfoState {
  final ContactInfoModel contactInfoModel;

  const GetContactInfoSuccess({required this.contactInfoModel});

  @override
  List<Object?> get props => [contactInfoModel];
}

class UpdateContactInfoSuccess extends ContactInfoState {}
