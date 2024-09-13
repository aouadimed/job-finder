import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/network/network_info.dart';
import 'package:cv_frontend/features/messaging/data/data_source/messaging_remote_data_source.dart';
import 'package:cv_frontend/features/messaging/data/models/get_chat_model.dart';
import 'package:cv_frontend/features/messaging/data/models/get_messages.dart';
import 'package:cv_frontend/features/messaging/domain/repository/messaging_repository.dart';
import 'package:cv_frontend/features/messaging/domain/usecases/get_chat_messages_use_case.dart';
import 'package:cv_frontend/features/messaging/domain/usecases/get_chats_use_case.dart';
import 'package:cv_frontend/features/messaging/domain/usecases/send_message_usecase.dart';
import 'package:dartz/dartz.dart';

class MessagingRepositoryImpl implements MessagingRepository {
  final SendMessageRemoteDataSource sendMessageRemoteDataSource;
  final NetworkInfo networkInfo;

  MessagingRepositoryImpl(
      {required this.sendMessageRemoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, void>> sendMessage(SendMessageParams params) async {
    if (await networkInfo.isConnected == false) {
      return Left(ConnexionFailure());
    }
    try {
      await sendMessageRemoteDataSource.sendMessage(params);

      return const Right(null);
    } catch (e) {
      return Left(ConnexionFailure());
    }
  }

  @override
  Future<Either<Failure, ChatModel>> getChats(GetChatsParams params) async {
    if (await networkInfo.isConnected == false) {
      return Left(ConnexionFailure());
    }
    try {
      final chatModel = await sendMessageRemoteDataSource.getChats(params);

      return Right(chatModel);
    } catch (e) {
      return Left(ConnexionFailure());
    }
  }

  @override
  Future<Either<Failure, Message>> getMessages(
      GetMessagesChatsParams params) async {
    if (await networkInfo.isConnected == false) {
      return Left(ConnexionFailure());
    }
    try {
      final chatModel = await sendMessageRemoteDataSource.getMessages(params);

      return Right(chatModel);
    } catch (e) {
      return Left(ConnexionFailure());
    }
  }
}
