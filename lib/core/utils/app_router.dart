import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_your_dev/core/utils/services/dependency_injection_service.dart';
import 'package:get_your_dev/features/auth/data/repos/auth_repo_impl.dart';
import 'package:get_your_dev/features/auth/presentation/view_model/drop_down_button_cubit/drop_down_button_cubit.dart';
import 'package:get_your_dev/features/auth/presentation/views/reset_password_view.dart';
import 'package:get_your_dev/features/auth/presentation/views/signup_view.dart';
import 'package:get_your_dev/features/chat/data/repos/chat_repo_impl.dart';
import 'package:get_your_dev/features/chat/presentation/view_model/chat_cubit/chat_cubit.dart';
import 'package:get_your_dev/features/chat/presentation/views/contacts_view.dart';
import 'package:get_your_dev/features/home/presentation/views/edit_email_view.dart';
import 'package:get_your_dev/features/home/presentation/views/edit_password_view.dart';
import 'package:get_your_dev/features/home/presentation/views/edit_username_view.dart';
import '../../features/auth/presentation/view_model/auth_cubit/auth_cubit.dart';
import '../../features/auth/presentation/view_model/change_password_icon_cubit/change_password_icon_cubit.dart';
import '../../features/auth/presentation/views/signin_view.dart';
import '../../features/chat/presentation/views/chat_view.dart';
import '../../features/home/presentation/views/add_developer_view.dart';
import '../../features/home/presentation/views/developer_details_view.dart';
import '../../features/home/presentation/views/home_view.dart';
import '../../features/home/presentation/views/user_informations_view.dart';

class AppRouter {
  static const kSignupView = '/signupView';
  static const kSigninView = '/signinView';
  static const kHomeView = '/homeView';
  static const kAddDeveloperView = '/addDeveloperView';
  static const kUserInformationsView = '/userInformationsView';
  static const kResetPasswordView = '/resetPasswordView';
  static const kEditUsernameView = '/editUsernameView';
  static const kEditEmailView = '/editEmailView';
  static const kEditPasswordView = '/editPasswordView';
  static const kDeveloperDetailsView = '/developerDetailsView';
  static const kChatView = '/chatView';
  static const kContactsView = '/contactsView';

  static Map<String, Widget Function(BuildContext)> routes = {
    kSignupView: (context) => MultiBlocProvider(providers: [
          BlocProvider(
            create: (context) => DropDownButtonCubit(),
          ),
          BlocProvider(
            create: (context) => ChangePasswordIconCubit(),
          ),
          BlocProvider(
            create: (context) => AuthCubit(getIt.get<AuthRepoImpl>()),
          ),
        ], child: const SignupView()),
    kSigninView: (context) => MultiBlocProvider(providers: [
          BlocProvider(
            create: (context) => ChangePasswordIconCubit(),
          ),
          BlocProvider(
            create: (context) => AuthCubit(getIt.get<AuthRepoImpl>()),
          ),
        ], child: const SigninView()),
    kHomeView: (context) => const HomeView(),
    kAddDeveloperView: (context) => const AddDeveloperView(),
    kUserInformationsView: (context) => const UserInformationsView(),
    kResetPasswordView: (context) => BlocProvider(
        create: (context) => AuthCubit(getIt.get<AuthRepoImpl>()),
        child: const ResetPasswordView()),
    kEditUsernameView: (context) => const EditUsernameView(),
    kEditEmailView: (context) => const EditEmailView(),
    kEditPasswordView: (context) => const EditPasswordView(),
    kDeveloperDetailsView: (context) => const DeveloperDetailsView(),
    kChatView: (context) => BlocProvider(
          create: (context) => ChatCubit(getIt.get<ChatRepoImpl>()),
          child: const ChatView(),
        ),
    kContactsView: (context) => BlocProvider(
        create: (context) => ChatCubit(getIt.get<ChatRepoImpl>()),
        child: const ContactsView())
  };
}
