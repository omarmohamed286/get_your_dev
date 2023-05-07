import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_your_dev/app/utils/services/user_data_service.dart';
import 'package:get_your_dev/view_models/user_data_cubit/user_data_cubit.dart';
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
    HomeScreen.id: (context) => const HomeScreen(),
    UserInfromationsScreen.id: (context) => const UserInfromationsScreen(),
    SettingsScreen.id: (context) => const SettingsScreen(),
    EditInfoScreen.id: (context) => const EditInfoScreen(),
    ResetPasswordScreen.id: (context) => const ResetPasswordScreen()
  };
}
