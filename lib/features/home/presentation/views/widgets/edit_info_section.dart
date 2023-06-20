import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_your_dev/core/utils/custom_snack_bar.dart';
import 'package:get_your_dev/core/widgets/custom_loading_indicator.dart';
import 'package:get_your_dev/features/home/presentation/view_model/user_data_cubit/user_data_cubit.dart';
import '../../../../../core/widgets/custom_button.dart';
import 'custom_text_field.dart';

class EditInfoSection extends StatelessWidget {
  const EditInfoSection({
    super.key,
    required this.oldInfo,
    required this.onOkPressed,
    required this.onChanged,
    required this.info,
  });

  final String oldInfo;
  final String info;
  final void Function() onOkPressed;
  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(
              labelText: info,
              initialValue: oldInfo,
              onChanged: onChanged,
              obscureText: info == 'كلمة المرور',
              textInputAction: TextInputAction.done,
            ),
            const SizedBox(height: 20),
            BlocConsumer<UserDataCubit, UserDataState>(
              listener: (context, state) {
                if (state is UpdateUserDataFailure) {
                  showErrorSnackBar(
                      context: context, content: state.errMessage);
                  Navigator.pop(context);
                } else if (state is UpdateUserDataSuccess) {
                  showSuccessSnackBar(
                      context: context, content: 'تم تغيير $info بنجاح');
                  Navigator.pop(context);
                }
              },
              builder: (context, state) {
                if (state is UpdateUserDataLoading) {
                  return const CustomLoadingIndicator();
                }
                return CustomButton(
                  text: 'تأكيد',
                  onPressed: onOkPressed,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
