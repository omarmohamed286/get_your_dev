import 'package:flutter/material.dart';

void showSnackBar(
    {required BuildContext context,
    required String content,
    required Color? backgroundColor,
    int? seconds}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    duration: Duration(seconds: seconds ?? 2),
    content: Text(content, style: const TextStyle(fontFamily: 'Tajawal')),
    backgroundColor: backgroundColor,
  ));
}
