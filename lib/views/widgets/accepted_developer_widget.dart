import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_your_dev/models/developer_model.dart';
import 'package:get_your_dev/views/widgets/developer_card.dart';

class AcceptedDeveloperWidget extends StatelessWidget {
  const AcceptedDeveloperWidget({super.key, required this.developerModel});

  final DeveloperModel developerModel;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(8.0.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'تم قبول طلبك وسوف يظهر للعملاء بهذا الشكل:',
              style: TextStyle(fontSize: 24.sp),
            ),
            SizedBox(height: 10.h),
            DeveloperCard(developerModel: developerModel),
          ],
        ),
      ),
    );
  }
}

