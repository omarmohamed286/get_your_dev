import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import '../../../../../core/constants.dart';
import '../../../../../core/utils/app_router.dart';
import '../../../../../core/utils/custom_dialog.dart';
import '../../../../../core/utils/services/cache_service.dart';
import '../../../../../core/utils/services/user_data_service.dart';
import 'custom_card.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: kWhiteColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomCard(
            title: 'اعرض نفسك كـ مطور',
            icon: Icons.code,
            onTap: () {
              Navigator.pushNamed(context, AppRouter.kAddDeveloperView);
            },
          ),
          CustomCard(
            title: 'معلومات المستخدم',
            icon: Icons.person,
            onTap: () {
              Navigator.pushNamed(context, AppRouter.kUserInformationsView);
            },
          ),
          CustomCard(
            title: 'المحادثات',
            icon: Icons.chat,
            onTap: () {},
          ),
          CustomCard(
            title: 'تسجيل الخروج',
            icon: Icons.logout,
            onTap: () {
              customInfoDialog(
                context: context,
                title: 'هل أنت متأكد!',
                description: 'هل أنت متأكد أنك تريد تسجيل الخروج؟',
                onOkPress: () {
                  CacheService.removeBool(kIsLogedKey);
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
