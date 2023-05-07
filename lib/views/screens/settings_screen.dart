import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_your_dev/app/utils/helpers/app_bar_helper.dart';
import 'package:get_your_dev/view_models/user_data_cubit/user_data_cubit.dart';
import 'package:get_your_dev/views/screens/edit_info_screen.dart';
import '../../models/user_model.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static String id = 'settingsScreen';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDataCubit, UserDataState>(
      builder: (context, state) {
        UserModel? userModel =
            BlocProvider.of<UserDataCubit>(context).userModel;
        return Scaffold(
            appBar: getAppBar(title: 'الإعدادات'),
            body: ListView(padding: EdgeInsets.all(12.h), children: [
              ListTile(
                title: const Text('اسم المستخدم'),
                subtitle: Text(userModel!.username),
                trailing: TextButton(
                  child: const Text('تعديل'),
                  onPressed: () {
                    Navigator.pushNamed(context, EditInfoScreen.id, arguments: {
                      'field': 'اسم المستخدم',
                      'value': userModel.username
                    });
                  },
                ),
              ),
              SizedBox(height: 30.h),
              ListTile(
                title: const Text('البريد الإلكتروني'),
                subtitle: Text(userModel.email),
                trailing: TextButton(
                  child: const Text('تعديل'),
                  onPressed: () {
                    Navigator.pushNamed(context, EditInfoScreen.id, arguments: {
                      'field': 'البريد الإلكتروني',
                      'value': userModel.email
                    });
                  },
                ),
              ),
              SizedBox(height: 30.h),
              ListTile(
                title: const Text('كلمة المرور'),
                trailing: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, EditInfoScreen.id,
                          arguments: {'field': 'كلمة المرور', 'value': ''});
                    },
                    child: const Text('تعديل')),
              ),
            ]));
      },
    );
  }
}
