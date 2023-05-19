import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_your_dev/app/utils/helpers/app_bar_helper.dart';
import 'package:get_your_dev/models/contact_model.dart';
import 'package:get_your_dev/models/user_model.dart';
import 'package:get_your_dev/view_models/chat_cubit/chat_cubit.dart';
import 'package:get_your_dev/view_models/user_data_cubit/user_data_cubit.dart';
import 'package:get_your_dev/views/widgets/custom_text_field.dart';
import 'package:get_your_dev/views/widgets/first_user_message.dart';
import 'package:get_your_dev/views/widgets/second_user_message.dart';
import '../../models/message_model.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  static const id = 'chatScreen';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String? message;
  TextEditingController myController = TextEditingController();
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    dynamic model = ModalRoute.of(context)!.settings.arguments as dynamic;
    UserModel userModel = BlocProvider.of<UserDataCubit>(context).userModel!;
    return Scaffold(
        appBar: getAppBar(title: 'محادثة'),
        body: StreamBuilder<QuerySnapshot>(
          stream: BlocProvider.of<ChatCubit>(context)
              .getMessages(firstUser: userModel.email, secondUser: model.email),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<MessageModel> messagesList = [];
              var data = snapshot.data!.docs;
              for (int i = 0; i < data.length; i++) {
                messagesList.add(MessageModel.fromJson(
                    data[i].data() as Map<String, dynamic>));
              }
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: messagesList.length,
                      reverse: true,
                      controller: scrollController,
                      itemBuilder: (context, i) {
                        return messagesList[i].id == userModel.email
                            ? FirstUserMessage(messageModel: messagesList[i])
                            : SecondUserMessage(messageModel: messagesList[i]);
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.h),
                    child: CustomTextField(
                      controller: myController,
                      prefixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.send),
                      ),
                      onFieldSubmitted: (value) {
                        message = value;
                        if (messagesList.isEmpty) {
                          BlocProvider.of<ChatCubit>(context)
                              .addUserToContactList(
                                  firstUserContact: ContactModel(
                                      email: model.email,
                                      image: model.image,
                                      username: model.name),
                                  secondUserContact: ContactModel(
                                      email: userModel.email,
                                      image: userModel.image,
                                      username: userModel.username));
                        }
                        if (message != null) {
                          messagesList.clear();
                          BlocProvider.of<ChatCubit>(context).sendMessage(
                              message: MessageModel(
                                  message: message!, id: userModel.email),
                              firstUser: userModel.email,
                              secondUser: model.email);
                          myController.clear();
                          scrollController.animateTo(
                              scrollController.position.minScrollExtent,
                              duration: const Duration(seconds: 1),
                              curve: Curves.bounceInOut);
                        }
                      },
                    ),
                  ),
                ],
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ));
  }
}
