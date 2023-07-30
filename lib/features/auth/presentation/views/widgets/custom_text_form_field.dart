import 'package:flutter/material.dart';
import 'package:get_your_dev/core/utils/app_styles.dart';
import 'package:get_your_dev/core/utils/custom_border.dart';
import '../../../../../core/constants.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.labelText,
      this.onSaved,
      this.textInputAction = TextInputAction.next,
      this.onChanged});

  final String labelText;
  final void Function(String?)? onSaved;
  final TextInputAction? textInputAction;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return 'يجب إدخال $labelText';
        }
        return null;
      },
      onSaved: onSaved,
      onChanged: onChanged,
      textInputAction: textInputAction,
      cursorColor: kBlackColor,
      decoration: InputDecoration(
        focusedBorder: customBorder(),
        enabledBorder: customBorder(),
        labelText: labelText,
        labelStyle: AppStyles.defaultTextStyle,
      ),
    );
  }
}
