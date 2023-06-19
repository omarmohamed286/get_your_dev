import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants.dart';

class UploadPhotoButton extends StatelessWidget {
  const UploadPhotoButton(
      {super.key,
      required this.icon,
      required this.onPressed,
      required this.iconRadius});

  final IconData icon;
  final int iconRadius;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: CircleAvatar(
        radius: iconRadius.r,
        backgroundColor: kBlackColor,
        child: IconButton(
          color: Colors.white,
          onPressed: onPressed,
          icon: Icon(
            icon,
            size: 18.h,
          ),
        ),
      ),
    );
  }
}