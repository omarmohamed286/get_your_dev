import 'package:flutter/material.dart';

void showSnackBar(
    {required BuildContext context,
    required String content,
    required Color? backgroundColor}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    duration: const Duration(seconds: 2),
    content: Text(content, style: const TextStyle(fontFamily: 'Tajawal')),
    backgroundColor: backgroundColor,
  ));
}
