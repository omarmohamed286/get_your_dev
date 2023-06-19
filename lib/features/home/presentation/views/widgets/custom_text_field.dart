import 'package:flutter/material.dart';
import 'package:get_your_dev/core/utils/app_styles.dart';
import 'package:get_your_dev/core/utils/custom_border.dart';
import '../../../../../core/constants.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.labelText,
    this.onChanged,
    this.initialValue,
    this.obscureText,
  });

  final String labelText;
  final void Function(String)? onChanged;
  final String? initialValue;
  final bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText ?? false,
      initialValue: initialValue,
      onChanged: onChanged,
      textInputAction: TextInputAction.done,
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
