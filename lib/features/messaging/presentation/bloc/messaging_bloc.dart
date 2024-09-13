import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/errors/functions.dart';
import 'package:cv_frontend/features/messaging/domain/usecases/get_chat_messages_use_case.dart';
import 'package:cv_frontend/features/messaging/domain/usecases/get_chats_use_case.dart';
import 'package:cv_frontend/features/messaging/domain/usecases/send_message_usecase.dart';
import 'package:cv_frontend/features/messaging/data/models/get_chat_model.dart';
import 'package:cv_frontend/features/messaging/data/models/get_messages.dart'; // Import model
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'messaging_event.dart';
part 'messaging_state.dart';

class MessagingBloc extends Bloc<MessagingEvent, MessagingState> {
  final SendMessageUsecase sendMessageUsecase;
  final GetChatsUseCase getChatsUseCase;
  final GetMessagesChatUseCase getMessagesChatUseCase;

  ChatModel? _currentChatModel;
  Message? _currentChatMessage;
  bool _hasMoreChats = true;
  bool _hasMoreMessages = true;

  MessagingBloc({
    required this.sendMessageUsecase,
    required this.getChatsUseCase,
    required this.getMessagesChatUseCase,
  }) : super(MessagingInitial()) {
    on<SendMessageEvent>(_onSendMessageEvent);
    on<GetChatsEvent>(_onGetChatsEvent);
    on<GetMessagesChatEvent>(_onGetMessagesChatEvent);
  }

  bool get hasMoreChats => _hasMoreChats;
  bool get hasMoreMessages => _hasMoreMessages;

  Future<void> _onSendMessageEvent(
      SendMessageEvent event, Emitter<MessagingState> emit) async {
    emit(SendingMessageLoading());

    final result = await sendMessageUsecase.call(
      SendMessageParams(receiver: event.receiver, content: event.content),
    );

    result.fold(
      (failure) => emit(MessagingFailure(
        message: mapFailureToMessage(failure),
        isIntentFailure: failure is ConnexionFailure,
      )),
      (_) => emit(MessagingSuccess()),
    );
  }

  Future<void> _onGetChatsEvent(
      GetChatsEvent event, Emitter<MessagingState> emit) async {
    emit(MessagingLoading());

    final result = await getChatsUseCase.call(GetChatsParams(page: event.page ?? '1'));

    result.fold(
      (failure) => emit(MessagingFailure(
        message: mapFailureToMessage(failure),
        isIntentFailure: failure is ConnexionFailure,
      )),
      (chatModel) {
        if (_currentChatModel == null || event.page == '1') {
          _currentChatModel = chatModel;
        } else {
          _currentChatModel?.chats?.addAll(chatModel.chats ?? []);
        }

        _hasMoreChats = chatModel.currentPage! < chatModel.totalPages!;
        emit(GetChatsSuccess(chatModel: _currentChatModel!));
      },
    );
  }

  Future<void> _onGetMessagesChatEvent(
      GetMessagesChatEvent event, Emitter<MessagingState> emit) async {
    emit(MessagingLoading());

    final result = await getMessagesChatUseCase.call(
      GetMessagesChatsParams(id: event.id, page: event.page ?? '1'),
    );

    result.fold(
      (failure) => emit(MessagingFailure(
        message: mapFailureToMessage(failure),
        isIntentFailure: failure is ConnexionFailure,
      )),
      (chatMessage) {
        if (_currentChatMessage == null || event.page == '1') {
          _currentChatMessage = chatMessage;
        } else {
          _currentChatMessage?.messages.addAll(chatMessage.messages);
        }

        _hasMoreMessages = chatMessage.currentPage < chatMessage.totalPages;
        emit(GetMessagesSuccess(chatMessage: _currentChatMessage!));
      },
    );
  }
}
