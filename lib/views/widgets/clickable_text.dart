import 'package:flutter/material.dart';

class ClickableText extends StatelessWidget {
  const ClickableText({super.key, required this.onTap, required this.text});

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        text,
        style: const TextStyle(color: Colors.blue),
      ),
    );
  }
}
