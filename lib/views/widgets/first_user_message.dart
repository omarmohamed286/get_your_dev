import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_your_dev/app/utils/constants.dart';

import '../../models/message_model.dart';

class FirstUserMessage extends StatelessWidget {
  const FirstUserMessage({super.key, required this.messageModel});

  final MessageModel messageModel;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.all(10.h),
        padding: EdgeInsets.all(16.h),
        decoration: BoxDecoration(
            color: Constants.blackColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32.r),
                topRight: Radius.circular(32.r),
                bottomRight: Radius.circular(32.r))),
        child: Text(
          messageModel.message,
          style: const TextStyle(color: Constants.whiteColor),
        ),
      ),
    );
  }
}
