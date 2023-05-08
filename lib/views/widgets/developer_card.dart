import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_your_dev/views/screens/developer_details_screen.dart';
import 'package:get_your_dev/views/widgets/custom_cached_image.dart';
import '../../models/developer_model.dart';

class DeveloperCard extends StatelessWidget {
  const DeveloperCard({super.key, required this.developerModel});

  final DeveloperModel developerModel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.h),
        child: Column(
          children: [
            Row(
              children: [
                CustomCachedImage(
                    imageUrl: developerModel.image, width: 90, height: 100),
                SizedBox(width: 28.w),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(developerModel.name,
                        style: TextStyle(fontSize: 24.sp)),
                    Text(developerModel.field,
                        style: TextStyle(
                            fontSize: 18.sp,
                            color: Colors.black.withOpacity(0.6))),
                  ],
                ),
              ],
            ),
            SizedBox(height: 30.h),
            Text(developerModel.shortDescription),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, DeveloperDetailsScreen.id,
                      arguments: developerModel);
                },
                child: const Text('اعرف المزيد عنه'))
          ],
        ),
      ),
    ));
  }
}
