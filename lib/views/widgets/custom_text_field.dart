import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_your_dev/view_models/change_password_icon_cubit/change_password_icon_cubit.dart';
import '../../app/utils/constants.dart';
import '../../app/utils/helpers/border_helper.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      this.labelText,
      this.keyword,
      this.onSaved,
      this.initialValue,
      this.onChanged,
      this.maxLength,
      this.maxLines,
      this.prefixIcon,
      this.onFieldSubmitted,
      this.controller});

  final String? labelText;
  final String? keyword;
  final void Function(String?)? onSaved;
  final String? initialValue;
  final void Function(String)? onChanged;
  final int? maxLength;
  final int? maxLines;
  final IconButton? prefixIcon;
  final void Function(String)? onFieldSubmitted;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangePasswordIconCubit(),
      child: BlocBuilder<ChangePasswordIconCubit, ChangePasswordIconState>(
        builder: (context, state) {
          return TextFormField(
            onEditingComplete: () {},
            controller: controller,
            keyboardType: TextInputType.text,
            initialValue: initialValue,
            maxLength: maxLength,
            maxLines: keyword != 'dev' ? 1 : maxLines,
            obscureText: keyword == 'password'
                ? BlocProvider.of<ChangePasswordIconCubit>(context).obscureText
                : false,
            onSaved: onSaved,
            onChanged: onChanged,
            onFieldSubmitted: onFieldSubmitted,
            validator: (value) {
              if (keyword == 'username') {
                if (value?.isEmpty ?? true) {
                  return 'يجب إدخال اسم المستخدم';
                }
              }
              if (keyword == 'email') {
                if (value?.isEmpty ?? true) {
                  return 'يجب إدخال البريد الإلكتروني';
                }
              }
              if (keyword == 'password') {
                if (value?.isEmpty ?? true) {
                  return 'يجب إدخال كلمة المرور';
                }
              } else {
                if (value?.isEmpty ?? true) {
                  return 'لا يمكن لهذا الحقل أن يكون فارغاً';
                }
              }
              return null;
            },
            cursorColor: Constants.blackColor,
            decoration: InputDecoration(
                prefixIcon: prefixIcon,
                suffixIcon: keyword == 'password'
                    ? IconButton(
                        icon: Icon(
                            BlocProvider.of<ChangePasswordIconCubit>(context)
                                .getIcon()),
                        onPressed: () {
                          BlocProvider.of<ChangePasswordIconCubit>(context)
                              .changePasswordIcon();
                        },
                      )
                    : null,
                focusedBorder: customBorder(),
                enabledBorder: customBorder(),
                labelText: labelText,
                labelStyle: const TextStyle(color: Constants.blackColor)),
          );
        },
      ),
    );
  }
}
