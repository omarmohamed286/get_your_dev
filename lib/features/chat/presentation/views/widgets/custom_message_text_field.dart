import 'package:flutter/material.dart';
import '../../../../../core/constants.dart';
import '../../../../../core/utils/custom_border.dart';

class CustomMessageTextField extends StatelessWidget {
  const CustomMessageTextField(
      {super.key, this.onChanged, this.prefixIcon, this.controller});

  final void Function(String)? onChanged;
  final Widget? prefixIcon;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      textInputAction: TextInputAction.newline,
      cursorColor: kBlackColor,
      decoration: InputDecoration(
          focusedBorder: customBorder(),
          enabledBorder: customBorder(),
          prefixIcon: prefixIcon),
    );
  }
}
