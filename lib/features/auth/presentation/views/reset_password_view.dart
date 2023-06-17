import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_your_dev/core/utils/custom_snack_bar.dart';
import 'package:get_your_dev/core/widgets/custom_loading_indicator.dart';
import 'package:get_your_dev/features/auth/presentation/view_model/auth_cubit/auth_cubit.dart';
import '../../../../core/widgets/custom_button.dart';
import 'widgets/custom_text_form_field.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  String? email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
                'سوف يتم إرسال رسالة إلي بريدك الإلكتروني لإستعادة كلمة المرور'),
            const SizedBox(height: 20),
            CustomTextField(
              labelText: 'أدخل بريدك الإلكتروني',
              textInputAction: TextInputAction.done,
              onChanged: (value) {
                email = value;
              },
            ),
            const SizedBox(height: 20),
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is SendPasswordResetEmailSuccess) {
                  showSuccessSnackBar(
                      context: context,
                      content:
                          'لقد تم إرسال رسالة إستعادة كلمة المرور الخاصة بك علي الإيميل');
                  Navigator.pop(context);
                } else if (state is SendPasswordResetEmailFailure) {
                  showErrorSnackBar(
                      context: context,
                      content: 'حدث خطأ، برجاء المحاولة مرة أخري');
                  Navigator.pop(context);
                }
              },
              builder: (context, state) {
                if (state is SendPasswordResetEmailLoading) {
                  return const CustomLoadingIndicator();
                } else if (state is SendPasswordResetEmailFailure) {
                  return Center(
                    child: Text(state.errMessage),
                  );
                }
                return CustomButton(
                    text: 'إرسال',
                    onPressed: () {
                      if (email != null) {
                        BlocProvider.of<AuthCubit>(context)
                            .sendPasswordResetEmail(email: email!);
                      }
                    });
              },
            )
          ],
        ),
      ),
    );
  }
}
