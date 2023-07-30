import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_your_dev/core/utils/app_router.dart';
import 'package:get_your_dev/core/utils/custom_app_bar.dart';
import 'package:get_your_dev/core/widgets/custom_loading_indicator.dart';
import 'package:get_your_dev/features/chat/presentation/view_model/chat_cubit/chat_cubit.dart';
import 'package:get_your_dev/features/chat/presentation/views/widgets/contact_card.dart';
import 'package:get_your_dev/features/home/presentation/view_model/user_data_cubit/user_data_cubit.dart';
import '../../../../core/models/user_model.dart';

class ContactsView extends StatefulWidget {
  const ContactsView({super.key});

  @override
  State<ContactsView> createState() => _ContactsViewState();
}

class _ContactsViewState extends State<ContactsView> {
  List<UserModel>? contactsList = [];
  @override
  void initState() {
    String userId = BlocProvider.of<UserDataCubit>(context).currentUser!.uId;
    BlocProvider.of<ChatCubit>(context).getUserContacts(userId: userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'المحادثات'),
      body: BlocConsumer<ChatCubit, ChatState>(
        listener: (context, state) {
          if (state is GetContactsSuccess) {
            contactsList = BlocProvider.of<ChatCubit>(context).userContacts;
          }
        },
        builder: (context, state) {
          if (state is GetContactsLoading) {
            return const CustomLoadingIndicator();
          }
          if (contactsList?.isEmpty ?? true) {
            return const Center(child: Text('لا يوجد لديك محادثات حتي الآن!'));
          }
          return ListView.builder(
            itemCount: contactsList!.length,
            itemBuilder: (context, i) {
              return ContactCard(
                contact: contactsList![i],
                onTap: () {
                  Navigator.pushNamed(context, AppRouter.kChatView,
                      arguments: contactsList![i]);
                },
              );
            },
          );
        },
      ),
    );
  }
}
