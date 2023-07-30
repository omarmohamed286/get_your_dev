import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_your_dev/core/models/user_model.dart';
import 'package:get_your_dev/core/utils/custom_app_bar.dart';
import 'package:get_your_dev/features/chat/data/models/message_model.dart';
import 'package:get_your_dev/features/chat/presentation/view_model/chat_cubit/chat_cubit.dart';
import 'package:get_your_dev/features/chat/presentation/views/widgets/first_user_message.dart';
import 'package:get_your_dev/features/chat/presentation/views/widgets/second_user_message.dart';
import 'package:get_your_dev/features/home/presentation/view_model/user_data_cubit/user_data_cubit.dart';
import '../../../../core/utils/services/dependency_injection_service.dart';
import '../../data/repos/chat_repo_impl.dart';
import 'widgets/custom_message_text_field.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  String? message;
  List<MessageModel> messagesList = [];
  TextEditingController textFieldController = TextEditingController();
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    UserModel secondUser =
        ModalRoute.of(context)!.settings.arguments as UserModel;
    UserModel? firstUser = BlocProvider.of<UserDataCubit>(context).currentUser;
    return Scaffold(
      appBar: customAppBar(title: 'محادثة'),
      body: BlocProvider(
        create: (context) => ChatCubit(getIt.get<ChatRepoImpl>()),
        child: Column(
          children: [
            BlocConsumer<ChatCubit, ChatState>(
              listener: (context, state) {
                if (state is GetMessagesSuccess) {
                  messagesList = state.messages;
                }
              },
              builder: (context, state) {
                BlocProvider.of<ChatCubit>(context).getMessages(
                    firstUserId: firstUser!.uId, secondUserId: secondUser.uId);
                if (state is GetMessagesFailure) {
                  return Center(
                    child: Text(state.errMessage),
                  );
                }
                return Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: scrollController,
                    itemCount: messagesList.length,
                    itemBuilder: (context, i) {
                      return messagesList[i].id == firstUser.uId
                          ? FirstUserMessage(messageModel: messagesList[i])
                          : SecondUserMessage(messageModel: messagesList[i]);
                    },
                  ),
                );
              },
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomMessageTextField(
                  controller: textFieldController,
                  prefixIcon: IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {
                      if (message != null) {
                        if (messagesList.isEmpty) {
                          BlocProvider.of<ChatCubit>(context)
                              .addUserToContactsList(
                                  firstUser: firstUser!,
                                  secondUser: secondUser);
                        }
                        BlocProvider.of<ChatCubit>(context).addMessage(
                            firstUserId: firstUser!.uId,
                            secondUserId: secondUser.uId,
                            message: MessageModel(
                                message: message!, id: firstUser.uId));
                        textFieldController.clear();
                        scrollController.animateTo(
                            scrollController.position.minScrollExtent,
                            duration: const Duration(seconds: 1),
                            curve: Curves.bounceInOut);
                      }
                    },
                  ),
                  onChanged: (value) {
                    message = value;
                  },
                ))
          ],
        ),
      ),
    );
  }
}
