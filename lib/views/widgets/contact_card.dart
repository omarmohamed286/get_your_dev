import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_your_dev/app/utils/constants.dart';
import 'package:get_your_dev/models/contact_model.dart';
import 'custom_cached_image.dart';

class ContactCard extends StatelessWidget {
  const ContactCard(
      {super.key, required this.contactModel, required this.onTap});

  final ContactModel contactModel;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.all(16.h),
        color: Constants.whiteColor,
        elevation: 6,
        child: Padding(
          padding: EdgeInsets.all(16.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomCachedImage(
                  imageUrl: contactModel.image, width: 70, height: 80),
              Column(
                children: [
                  Text(
                    contactModel.username,
                    style:
                        TextStyle(fontSize: 24.sp, color: Constants.blackColor),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
