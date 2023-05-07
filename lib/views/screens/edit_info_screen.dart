import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_your_dev/app/utils/helpers/app_bar_helper.dart';
import 'package:get_your_dev/app/utils/helpers/dialog_helper.dart';
import 'package:get_your_dev/app/utils/helpers/snack_bar_helper.dart';
import 'package:get_your_dev/view_models/user_data_cubit/user_data_cubit.dart';
import 'package:get_your_dev/views/widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class EditInfoScreen extends StatefulWidget {
  const EditInfoScreen({super.key});

  static String id = 'editInfoScreen';

  @override
  State<EditInfoScreen> createState() => _EditInfoScreenState();
}

class _EditInfoScreenState extends State<EditInfoScreen> {
  String? valueAfterEditing;

  @override
  Widget build(BuildContext context) {
    Map<String, String> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    return BlocConsumer<UserDataCubit, UserDataState>(
      listener: (context, state) {
        if (state is UserDataUpdateSuccess) {
          BlocProvider.of<UserDataCubit>(context).getUser();
          Navigator.pop(context);
          showSnackBar(
              context: context,
              content: 'تم التغيير بنجاح',
              backgroundColor: Colors.green);
        } else if (state is UserDataUpdateFailure) {
          customErrorDialog(context: context, description: state.errorMessage);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: getAppBar(title: 'تعديل البيانات'),
          body: Center(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(arguments['field']!),
                SizedBox(height: 20.h),
                CustomTextField(
                  initialValue: arguments['value'],
                  keyword:
                      arguments['field'] == 'كلمة المرور' ? 'password' : '',
                  labelText: arguments['field']!,
                  onChanged: (value) {
                    valueAfterEditing = value.trim();
                  },
                ),
                SizedBox(height: 20.h),
                state is UserDataUpdateLoading
                    ? const CircularProgressIndicator()
                    : CustomButton(
                        text: 'تأكيد',
                        onPressed: () {
                          customInfoDialog(
                            context: context,
                            title: '!هل أنت متأكد',
                            description: 'هل أنت متأكد أنك تريد إتمام التغيير؟',
                            onOkPress: () {
                              BlocProvider.of<UserDataCubit>(context)
                                  .updateUser(
                                      key: arguments['field']!,
                                      value: valueAfterEditing ??
                                          arguments['value']!);
                            },
                          ).show();
                        }),
              ],
            ),
          )),
        );
      },
    );
  }
}
