import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import '../../../../../core/constants.dart';
import '../../../../../core/utils/app_router.dart';
import '../../../../../core/utils/custom_dialog.dart';
import '../../../../../core/utils/services/cache_service.dart';
import '../../view_model/user_data_cubit/user_data_cubit.dart';
import 'custom_card.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    String userRole = BlocProvider.of<UserDataCubit>(context).currentUser!.role;
    return Drawer(
      backgroundColor: kWhiteColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          userRole == 'مطور'
              ? CustomCard(
                  title: 'اعرض نفسك كـ مطور',
                  icon: Icons.code,
                  onTap: () {
                    Navigator.pushNamed(context, AppRouter.kAddDeveloperView);
                  },
                )
              : const SizedBox.shrink(),
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
            onTap: () {
              Navigator.pushNamed(context, AppRouter.kContactsView);
            },
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
