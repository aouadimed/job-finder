import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/usecases/usecase.dart';
import 'package:cv_frontend/features/messaging/data/models/get_chat_model.dart';
import 'package:cv_frontend/features/messaging/domain/repository/messaging_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetChatsUseCase implements UseCase<ChatModel, GetChatsParams> {
  final MessagingRepository messagingRepository;

  GetChatsUseCase({required this.messagingRepository});

  @override
  Future<Either<Failure, ChatModel>> call(GetChatsParams params) async {
    return await messagingRepository.getChats(params);
  }
}

class GetChatsParams extends Equatable {
  final String page;

  const GetChatsParams({required this.page});
  @override
  List<Object?> get props => [page];
}
