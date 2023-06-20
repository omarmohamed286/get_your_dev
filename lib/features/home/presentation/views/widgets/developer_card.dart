import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_your_dev/core/constants.dart';
import 'package:get_your_dev/core/models/user_model.dart';
import 'package:get_your_dev/core/utils/app_router.dart';
import 'package:get_your_dev/core/utils/app_styles.dart';

import '../../view_model/user_data_cubit/user_data_cubit.dart';
import 'custom_cached_image.dart';

class DeveloperCard extends StatelessWidget {
  const DeveloperCard({super.key, required this.developer});

  final UserModel developer;

  @override
  Widget build(BuildContext context) {
    UserModel? currentUser =
        BlocProvider.of<UserDataCubit>(context).currentUser;
    bool isVisible = false;
    return Builder(builder: (context) {
      if (currentUser!.email != developer.email) {
        isVisible = true;
      }
      return Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  CustomCachedImage(
                      imageUrl: developer.image, width: 80, height: 100),
                  const SizedBox(width: 28),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(developer.username,
                          style: TextStyle(fontSize: 24.sp)),
                      Text(developer.field!,
                          style: TextStyle(
                              fontSize: 18.sp,
                              color: Colors.black.withOpacity(0.6))),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              Text(developer.shortDescription!),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, AppRouter.kDeveloperDetailsView,
                            arguments: developer);
                      },
                      child: Text(
                        'اعرف المزيد عنه',
                        style:
                            AppStyles.textStyle18.copyWith(color: Colors.blue),
                      )),
                  Visibility(
                    visible: isVisible,
                    child: TextButton(
                        onPressed: () {
                          // Navigator.pushNamed(context, ChatScreen.id,
                          //     arguments: developerModel);
                        },
                        child: Text('محادثة مباشرة',
                            style: AppStyles.textStyle18
                                .copyWith(color: Colors.blue))),
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
