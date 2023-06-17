import 'package:flutter/material.dart';
import 'package:get_your_dev/core/utils/app_styles.dart';
import '../constants.dart';


class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.text, required this.onPressed});

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Align(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: kBlackColor,
            padding: const EdgeInsets.all(18)),
        child: Text(text, style: AppStyles.textStyle18),
      ),
    );
  }
}
