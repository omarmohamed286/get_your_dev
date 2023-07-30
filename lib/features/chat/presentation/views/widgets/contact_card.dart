import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants.dart';
import '../../../../../core/models/user_model.dart';
import '../../../../home/presentation/views/widgets/custom_cached_image.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({super.key, required this.contact, required this.onTap});

  final UserModel contact;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.all(16.h),
        color: kWhiteColor,
        elevation: 6,
        child: Padding(
          padding: EdgeInsets.all(16.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomCachedImage(imageUrl: contact.image, width: 70, height: 80),
              Column(
                children: [
                  Text(
                    contact.username,
                    style: const TextStyle(fontSize: 24, color: kBlackColor),
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
