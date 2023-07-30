import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/custom_app_bar.dart';
import '../../../../core/utils/custom_dialog.dart';
import '../view_model/user_data_cubit/user_data_cubit.dart';
import 'widgets/edit_info_section.dart';

class EditPasswordView extends StatefulWidget {
  const EditPasswordView({super.key});

  @override
  State<EditPasswordView> createState() => _EditPasswordViewState();
}

class _EditPasswordViewState extends State<EditPasswordView> {
  String? newPassword;
  @override
  Widget build(BuildContext context) {
    final oldPassword = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: customAppBar(title: 'تعديل كلمة المرور'),
      body: EditInfoSection(
        info: 'كلمة المرور',
        oldInfo: oldPassword,
        onChanged: (value) {
          newPassword = value;
        },
        onOkPressed: () {
          customInfoDialog(
            context: context,
            title: 'هل أنت متأكد!',
            description: 'هل أنت متأكد انك تريد تغيير كلمة المرور؟',
            onOkPress: () async {
              if (newPassword != null) {
                await BlocProvider.of<UserDataCubit>(context)
                    .updateUserData(key: 'password', value: newPassword!.trim());
              }
            },
          ).show();
        },
      ),
    );
  }
}
