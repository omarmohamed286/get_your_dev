import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_your_dev/app/utils/helpers/snack_bar_helper.dart';
import 'package:get_your_dev/view_models/user_data_cubit/user_data_cubit.dart';
import 'package:get_your_dev/views/widgets/custom_button.dart';
import 'package:get_your_dev/views/widgets/custom_text_field.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  static const id = 'resetPasswordScreen';

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  String? email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
                'سوف يتم إرسال رسالة إلي بريدك الإلكتروني لإستعادة كلمة المرور'),
            SizedBox(height: 20.h),
            CustomTextField(
              labelText: 'أدخل بريدك الإلكتروني',
              keyword: 'email',
              onChanged: (value) {
                email = value;
              },
            ),
            SizedBox(height: 20.h),
            BlocConsumer<UserDataCubit, UserDataState>(
              listener: (context, state) {
                if (state is UserDataUpdateSuccess) {
                  showSnackBar(
                      context: context,
                      backgroundColor: Colors.green,
                      content:
                          'لقد تم إرسال رسالة لإستعادة كلمة المرور علي البريد الإلكتروني');
                  Navigator.pop(context);
                } else if (state is UserDataUpdateFailure) {
                  showSnackBar(
                      context: context,
                      backgroundColor: Colors.red,
                      content: 'حدث خطأ، يرجي المحاولة مرة أخري');
                  Navigator.pop(context);
                }
              },
              builder: (context, state) {
                return state is UserDataUpdateLoading
                    ? const CircularProgressIndicator()
                    : CustomButton(
                        text: 'إرسال',
                        onPressed: () async {
                          if (email != null) {
                            await BlocProvider.of<UserDataCubit>(context)
                                .sendPasswordResetEmail(email: email!);
                          }
                        });
              },
            ),
          ],
        ),
      ),
    );
  }
}
