import 'package:flutter/material.dart';
import 'package:get_your_dev/views/screens/add_developer_screen.dart';
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
    HomeScreen.id: (context) => const HomeScreen(),
    UserInfromationsScreen.id: (context) => const UserInfromationsScreen(),
    SettingsScreen.id: (context) => const SettingsScreen(),
    EditInfoScreen.id: (context) => const EditInfoScreen(),
    ResetPasswordScreen.id: (context) => const ResetPasswordScreen(),
    AddDeveloperScreen.id: (context) => const AddDeveloperScreen(),
    DeveloperDetailsScreen.id: (context) => const DeveloperDetailsScreen(),

  };
}
