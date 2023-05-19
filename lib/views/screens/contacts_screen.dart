import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_your_dev/app/utils/helpers/app_bar_helper.dart';
import 'package:get_your_dev/app/utils/helpers/dialog_helper.dart';
import 'package:get_your_dev/models/contact_model.dart';
import 'package:get_your_dev/view_models/chat_cubit/chat_cubit.dart';
import 'package:get_your_dev/view_models/user_data_cubit/user_data_cubit.dart';
import 'package:get_your_dev/views/screens/chat_screen.dart';
import '../widgets/contact_card.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  static const id = 'contactsScreen';

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  @override
  void initState() {
    String userEmail = BlocProvider.of<UserDataCubit>(context).userModel!.email;
    BlocProvider.of<ChatCubit>(context).getUserContacts(userEmail: userEmail);
    super.initState();
  }

  List<ContactModel> contactsList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(title: 'المحادثات'),
      body: BlocConsumer<ChatCubit, ChatState>(
        listener: (context, state) {
          if (state is ContactsDataSuccess) {
            contactsList = BlocProvider.of<ChatCubit>(context).contactsList;
          }
          if (state is ContactsDataFailure) {
            customErrorDialog(
                context: context, description: state.errorMessage);
          }
        },
        builder: (context, state) {
          return state is ContactsDataLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: contactsList.length,
                  itemBuilder: (context, i) {
                    return ContactCard(
                      contactModel: contactsList[i],
                      onTap: () {
                        Navigator.pushNamed(context, ChatScreen.id,
                            arguments: contactsList[i]);
                      },
                    );
                  },
                );
        },
      ),
    );
  }
}
