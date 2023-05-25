import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_your_dev/models/user_model.dart';
import 'package:get_your_dev/view_models/user_data_cubit/user_data_cubit.dart';
import 'package:get_your_dev/views/screens/chat_screen.dart';
import 'package:get_your_dev/views/screens/developer_details_screen.dart';
import 'package:get_your_dev/views/widgets/custom_cached_image.dart';
import '../../models/developer_model.dart';

class DeveloperCard extends StatelessWidget {
  const DeveloperCard({super.key, required this.developerModel});

  final DeveloperModel developerModel;

  @override
  Widget build(BuildContext context) {
    UserModel? currentUser = BlocProvider.of<UserDataCubit>(context).userModel;
    bool isVisible = false;
    return Builder(builder: (context) {
      if (currentUser!.email != developerModel.email) {
        isVisible = true;
      }
      return Card(
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
                      imageUrl: developerModel.image, width: 80, height: 100),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, DeveloperDetailsScreen.id,
                            arguments: developerModel);
                      },
                      child: const Text('اعرف المزيد عنه')),
                  Visibility(
                    visible: isVisible,
                    child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, ChatScreen.id,
                              arguments: developerModel);
                        },
                        child: const Text('محادثة مباشرة')),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}
