import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_your_dev/app/utils/services/chat_service.dart';
import 'package:get_your_dev/app/utils/services/notifications_service.dart';
import 'package:get_your_dev/view_models/chat_cubit/chat_cubit.dart';
import 'package:get_your_dev/view_models/notifications_cubit/notifications_cubit.dart';
import 'package:get_your_dev/views/screens/add_developer_screen.dart';
import 'package:get_your_dev/views/screens/chat_screen.dart';
import 'package:get_your_dev/views/screens/contacts_screen.dart';
import 'package:get_your_dev/views/screens/developer_details_screen.dart';
import 'package:get_your_dev/views/screens/home_screen.dart';
import 'package:get_your_dev/views/screens/settings_screen.dart';
import 'package:get_your_dev/views/screens/sign_in_screen.dart';
import 'package:get_your_dev/views/screens/user_informations_screen.dart';
import '../../views/screens/edit_info_screen.dart';
import '../../views/screens/reset_password_screen.dart';
import '../../views/screens/sign_up_screen.dart';

class AppRoutes {
  static Map<String, Widget Function(BuildContext)> routes = {
    SignUpScreen.id: (context) => const SignUpScreen(),
    SignInScreen.id: (context) => const SignInScreen(),
    HomeScreen.id: (context) => BlocProvider(
        create: (context) => ChatCubit(ChatService()),
        child: const HomeScreen()),
    UserInfromationsScreen.id: (context) => const UserInfromationsScreen(),
    SettingsScreen.id: (context) => const SettingsScreen(),
    EditInfoScreen.id: (context) => const EditInfoScreen(),
    ResetPasswordScreen.id: (context) => const ResetPasswordScreen(),
    AddDeveloperScreen.id: (context) => BlocProvider(
        create: (context) => NotificationsCubit(NotifiactionsService()),
        child: const AddDeveloperScreen()),
    DeveloperDetailsScreen.id: (context) => const DeveloperDetailsScreen(),
    ChatScreen.id: (context) => BlocProvider(
          create: (context) => ChatCubit(ChatService()),
          child: const ChatScreen(),
        ),
    ContactsScreen.id: (context) => BlocProvider(
        create: (context) => ChatCubit(ChatService()),
        child: const ContactsScreen()),
  };
}
