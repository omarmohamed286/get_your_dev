import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:get_your_dev/core/models/user_model.dart';
import 'package:meta/meta.dart';
import '../../../data/models/message_model.dart';
import '../../../data/repos/chat_repo.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit(this.chatRepo) : super(ChatInitial());

  final ChatRepo chatRepo;
  List<UserModel>? userContacts = [];

  Future<void> addMessage({
    required String firstUserId,
    required String secondUserId,
    required MessageModel message,
  }) async {
    await chatRepo.addMessage(
        firstUserId: firstUserId, secondUserId: secondUserId, message: message);
  }

  Future<void> getMessages({
    required String firstUserId,
    required String secondUserId,
  }) async {
    var result = chatRepo.getMessages(
        firstUserId: firstUserId, secondUserId: secondUserId);
    result.fold((failure) {
      emit(GetMessagesFailure(failure.errMessage));
    }, (messagesStream) {
      messagesStream.listen((event) {
        List<MessageModel> messages = [];
        for (var doc in event.docs) {
          messages
              .add(MessageModel.fromJson(doc.data() as Map<String, dynamic>));
        }
        if (!isClosed) {
          emit(GetMessagesSuccess(messages));
        }
      });
    });
  }

  Future<void> getUserContacts({required String userId}) async {
    emit(GetContactsLoading());
    var result = await chatRepo.getUserContacts(userId: userId);
    result.fold((failure) {
      emit(GetContactsFailure(failure.errMessage));
    }, (contacts) {
      userContacts = contacts;
      emit(GetContactsSuccess());
    });
  }

  Future<void> addUserToContactsList(
      {required UserModel firstUser, required UserModel secondUser}) async {
    await chatRepo.addUserToContactList(
        firstUser: firstUser, secondUser: secondUser);
  }

}
