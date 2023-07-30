import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/custom_app_bar.dart';
import '../../../../core/utils/custom_dialog.dart';
import '../view_model/user_data_cubit/user_data_cubit.dart';
import 'widgets/edit_info_section.dart';

class EditEmailView extends StatefulWidget {
  const EditEmailView({super.key});

  @override
  State<EditEmailView> createState() => _EditEmailViewState();
}

class _EditEmailViewState extends State<EditEmailView> {
  String? newEmail;
  @override
  Widget build(BuildContext context) {
    final oldEmail = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: customAppBar(title: 'تعديل البريد الإلكتروني'),
      body: EditInfoSection(
        info: 'البريد الإلكتروني',
        oldInfo: oldEmail,
        onChanged: (value) {
          newEmail = value;
        },
        onOkPressed: () {
          customInfoDialog(
            context: context,
            title: 'هل أنت متأكد!',
            description: 'هل أنت متأكد انك تريد تغيير البريد الإلكتروني؟',
            onOkPress: () {
              if (newEmail != null) {
                BlocProvider.of<UserDataCubit>(context)
                    .updateUserData(key: 'email', value: newEmail!.trim());
              }
            },
          ).show();
        },
      ),
    );
  }
}
