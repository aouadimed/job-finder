part of 'messaging_bloc.dart';

@immutable
abstract class MessagingState extends Equatable {
  const MessagingState();

  @override
  List<Object?> get props => [];
}

class MessagingInitial extends MessagingState {}

class MessagingLoading extends MessagingState {}

class SendingMessageLoading extends MessagingState {}

class MessagingSuccess extends MessagingState {}

class MessagingFailure extends MessagingState {
  final String message;
  final bool isIntentFailure;

  const MessagingFailure({
    required this.message,
    required this.isIntentFailure,
  });

  @override
  List<Object?> get props => [message, isIntentFailure];
}

class GetChatsSuccess extends MessagingState {
  final ChatModel chatModel;

  const GetChatsSuccess({required this.chatModel});

  @override
  List<Object?> get props => [chatModel];
}

class GetMessagesSuccess extends MessagingState {
  final Message chatMessage;

  const GetMessagesSuccess({required this.chatMessage});

  @override
  List<Object?> get props => [chatMessage];
}
