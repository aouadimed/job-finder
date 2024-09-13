import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/usecases/usecase.dart';
import 'package:cv_frontend/features/messaging/data/models/get_messages.dart';
import 'package:cv_frontend/features/messaging/domain/repository/messaging_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetMessagesChatUseCase
    implements UseCase<Message, GetMessagesChatsParams> {
  final MessagingRepository messagingRepository;

  GetMessagesChatUseCase({required this.messagingRepository});

  @override
  Future<Either<Failure, Message>> call(
      GetMessagesChatsParams params) async {
    return await messagingRepository.getMessages(params);
  }
}

class GetMessagesChatsParams extends Equatable {
  final String id;
  final String page;

  const GetMessagesChatsParams({required this.id, required this.page});

  @override
  List<Object?> get props => [page];
}
