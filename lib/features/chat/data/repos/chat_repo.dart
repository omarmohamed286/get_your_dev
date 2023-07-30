import 'package:dartz/dartz.dart';
import 'package:get_your_dev/core/errors/failures.dart';
import '../../../../core/models/user_model.dart';
import '../models/message_model.dart';

abstract class ChatRepo {
  Future<void> addMessage(
      {required String firstUserId,
      required String secondUserId,
      required MessageModel message});
  Future<void> addUserToContactList(
      {required UserModel firstUser, required UserModel secondUser});
  Future<Either<Failure, List<UserModel>?>> getUserContacts(
      {required String userId});
  Either<Failure, Stream> getMessages(
      {required String firstUserId, required String secondUserId});
}
