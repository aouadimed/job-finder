part of 'contact_info_bloc.dart';

@immutable
abstract class ContactInfoEvent extends Equatable {
  const ContactInfoEvent();

  @override
  List<Object?> get props => [];
}

class GetContactInfoEvent extends ContactInfoEvent {}

class UpdateContactInfoEvent extends ContactInfoEvent {
  final String address;
  final String phone;
  final String email;

  const UpdateContactInfoEvent({
    required this.address,
    required this.phone,
    required this.email,
  });

  @override
  List<Object?> get props => [address, phone, email];
}
