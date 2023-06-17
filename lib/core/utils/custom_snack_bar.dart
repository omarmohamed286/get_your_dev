import 'package:flutter/material.dart';
import 'package:get_your_dev/core/utils/app_styles.dart';

void showSuccessSnackBar({
  required BuildContext context,
  required String content,
}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      content,
      style: AppStyles.defaultTextStyle.copyWith(
        color: Colors.white,
      ),
    ),
    backgroundColor: Colors.green,
  ));
}

void showErrorSnackBar({
  required BuildContext context,
  required String content,
}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      content,
      style: AppStyles.defaultTextStyle.copyWith(
        color: Colors.white,
      ),
    ),
    backgroundColor: Colors.red,
  ));
}
