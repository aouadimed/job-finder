part of 'messaging_bloc.dart';

@immutable
abstract class MessagingEvent extends Equatable {
  const MessagingEvent();

  @override
  List<Object?> get props => [];
}

class SendMessageEvent extends MessagingEvent {
  final String receiver;
  final String content;

  const SendMessageEvent({
    required this.receiver,
    required this.content,
  });

  @override
  List<Object?> get props => [receiver, content];
}

class GetChatsEvent extends MessagingEvent {
  final String? page;

  const GetChatsEvent({
    this.page = '1',
  });

  @override
  List<Object?> get props => [page];
}

class GetMessagesChatEvent extends MessagingEvent {
  final String id;
  final String? page;

  const GetMessagesChatEvent({
    required this.id,
    this.page = '1',
  });

  @override
  List<Object?> get props => [id, page];
}
