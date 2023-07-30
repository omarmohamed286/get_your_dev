import 'package:get_your_dev/core/utils/services/chat_service.dart';
import 'package:get_your_dev/features/chat/data/models/message_model.dart';
import 'package:get_your_dev/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:get_your_dev/features/chat/data/repos/chat_repo.dart';
import '../../../../core/models/user_model.dart';

class ChatRepoImpl implements ChatRepo {
  final ChatService chatService;

  ChatRepoImpl(this.chatService);

  @override
  Future<void> addMessage(
      {required String firstUserId,
      required String secondUserId,
      required MessageModel message}) async {
    await chatService.addMessage(
        firstUserId: firstUserId, secondUserId: secondUserId, message: message);
  }

  @override
  Either<Failure, Stream> getMessages(
      {required String firstUserId, required String secondUserId}) {
    try {
      return right(chatService.getMessages(
          firstUserId: firstUserId, secondUserId: secondUserId));
    } catch (e) {
      return left(const ServerFailure('فشل إرسال الرسالة'));
    }
  }

  @override
  Future<Either<Failure, List<UserModel>?>> getUserContacts(
      {required String userId}) async {
    try {
      return right(await chatService.getUserContacts(userId: userId));
    } catch (e) {
      return left(const ServerFailure('فشل تحميل المحادثات'));
    }
  }

  @override
  Future<void> addUserToContactList(
      {required UserModel firstUser,
      required UserModel secondUser}) async {
    await chatService.addUserToContactList(
        firstUser: firstUser, secondUser: secondUser);
  }
}
