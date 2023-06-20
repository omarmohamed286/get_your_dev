import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_your_dev/core/utils/custom_app_bar.dart';
import 'package:get_your_dev/core/utils/custom_dialog.dart';
import 'package:get_your_dev/features/home/presentation/view_model/user_data_cubit/user_data_cubit.dart';
import '../../../../core/utils/custom_snack_bar.dart';
import 'widgets/edit_info_section.dart';

class EditUsernameView extends StatefulWidget {
  const EditUsernameView({super.key});

  @override
  State<EditUsernameView> createState() => _EditUsernameViewState();
}

class _EditUsernameViewState extends State<EditUsernameView> {
  String? newUsername;
  @override
  Widget build(BuildContext context) {
    final oldUsername = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: customAppBar(title: 'تعديل اسم المستخدم'),
      body: EditInfoSection(
        info: 'اسم المستخدم',
        oldInfo: oldUsername,
        onChanged: (value) {
          newUsername = value;
        },
        onOkPressed: () {
          customInfoDialog(
            context: context,
            title: 'هل أنت متأكد!',
            description: 'هل أنت متأكد انك تريد تغيير اسم المستخدم؟',
            onOkPress: () {
              if (newUsername != null) {
                BlocProvider.of<UserDataCubit>(context)
                    .updateUserData(key: 'username', value: newUsername!.trim());
              }
            },
          ).show();
        },
      ),
    );
  }
}
