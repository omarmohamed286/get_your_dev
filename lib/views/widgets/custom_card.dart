import 'package:flutter/material.dart';
import '../../app/utils/constants.dart';

class CustomCard extends StatelessWidget {
  const CustomCard(
      {super.key,
      required this.title,
      required this.onTap,
      required this.icon});

  final String title;
  final VoidCallback onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(color: Constants.blackColor),
        ),
        leading: Icon(icon),
        iconColor: Constants.blackColor,
      ),
    );
  }
}
