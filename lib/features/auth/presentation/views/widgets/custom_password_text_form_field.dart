import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/custom_border.dart';
import '../../view_model/change_password_icon_cubit/change_password_icon_cubit.dart';

class CustomPasswordTextFormField extends StatelessWidget {
  const CustomPasswordTextFormField(
      {super.key, required this.labelText, this.onSaved});

  final String labelText;
  final void Function(String?)? onSaved;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangePasswordIconCubit, ChangePasswordIconState>(
      builder: (context, state) {
        IconData currentIcon =
            BlocProvider.of<ChangePasswordIconCubit>(context).getIcon();
        bool obscureText =
            BlocProvider.of<ChangePasswordIconCubit>(context).obscureText;
        return TextFormField(
          validator: (value) {
            if (value?.isEmpty ?? true) {
              return 'يجب إدخال $labelText';
            }
            return null;
          },
          onSaved: onSaved,
          textInputAction: TextInputAction.done,
          cursorColor: kBlackColor,
          obscureText: obscureText,
          decoration: InputDecoration(
            suffixIcon: IconButton(
                onPressed: () {
                  BlocProvider.of<ChangePasswordIconCubit>(context)
                      .changePasswordIcon();
                },
                icon: Icon(currentIcon)),
            focusedBorder: customBorder(),
            enabledBorder: customBorder(),
            labelText: labelText,
            labelStyle: AppStyles.defaultTextStyle,
          ),
        );
      },
    );
  }
}
