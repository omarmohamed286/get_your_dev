import 'package:flutter/material.dart';
import 'package:get_your_dev/core/utils/app_styles.dart';
import 'package:get_your_dev/core/utils/custom_border.dart';
import '../../../../../core/constants.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.labelText,
    this.onChanged,
    this.initialValue,
    this.obscureText,
    this.maxLength,
    this.maxLines,
    required this.textInputAction,
  });

  final String? labelText;
  final void Function(String)? onChanged;
  final String? initialValue;
  final bool? obscureText;
  final int? maxLength;
  final int? maxLines;
  final TextInputAction textInputAction;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText ?? false,
      maxLength: maxLength,
      maxLines: maxLines ?? 1,
      initialValue: initialValue,
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
