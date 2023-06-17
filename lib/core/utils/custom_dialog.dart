import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

AwesomeDialog customInfoDialog({
  required BuildContext context,
  required String title,
  required String description,
  required VoidCallback onOkPress,
}) =>
    AwesomeDialog(
        context: context,
        dialogType: DialogType.info,
        animType: AnimType.scale,
        title: title,
        desc: description,
        btnOkOnPress: () {},
        btnCancelOnPress: onOkPress,
        btnOkText: 'إلغاء',
        btnCancelText: 'نعم');
