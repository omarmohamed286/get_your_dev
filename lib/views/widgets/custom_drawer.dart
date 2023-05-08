import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get_your_dev/view_models/user_data_cubit/user_data_cubit.dart';
import 'package:get_your_dev/views/screens/add_developer_screen.dart';
import 'package:get_your_dev/views/screens/settings_screen.dart';
import '../../app/utils/constants.dart';
import '../../app/utils/helpers/dialog_helper.dart';
import '../../app/utils/services/cache_service.dart';
import '../screens/user_informations_screen.dart';
import 'custom_card.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    String userRole = BlocProvider.of<UserDataCubit>(context).userModel!.role;
    return Drawer(
      backgroundColor: Constants.whiteColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          userRole == 'مطور'
              ? CustomCard(
                  title: 'اعرض نفسك كـ مطور',
                  icon: Icons.code,
                  onTap: () {
                    Navigator.pushNamed(context, AddDeveloperScreen.id);
                  },
                )
              : const SizedBox.shrink(),
          CustomCard(
            title: 'معلومات المستخدم',
            icon: Icons.person,
            onTap: () {
              Navigator.pushNamed(context, UserInfromationsScreen.id);
            },
          ),
          CustomCard(
            title: 'الإعدادات',
            icon: Icons.settings,
            onTap: () {
              Navigator.pushNamed(context, SettingsScreen.id);
            },
          ),
          CustomCard(
            title: 'تسجيل الخروج',
            icon: Icons.logout,
            onTap: () {
              customInfoDialog(
                context: context,
                title: '!هل أنت متأكد',
                description: 'هل أنت متأكد أنك تريد تسجيل الخروج؟',
                onOkPress: () {
                  CacheService.removeBool(Constants.isLogedKey);
                  Phoenix.rebirth(context);
                },
              ).show();
            },
          ),
        ],
      ),
    );
  }
}
