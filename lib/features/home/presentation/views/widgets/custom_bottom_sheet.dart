import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants.dart';
import '../../view_model/user_data_cubit/user_data_cubit.dart';

class CustomBottomSheet extends StatefulWidget {
  const CustomBottomSheet({super.key});

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  String? pickedImage;

  @override
  Widget build(BuildContext context) {
    UserDataCubit usersCubit = BlocProvider.of<UserDataCubit>(context);
    return Container(
      height: 130.h,
      padding: EdgeInsets.all(32.h),
      color: kWhiteColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: () async {
              Navigator.pop(context);
              usersCubit.updateUserImage(source: 'gallery');
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(Icons.photo_library, size: 32.h),
                Text(
                  'من الاستوديو',
                  style: TextStyle(fontSize: 18.sp),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () async {
              Navigator.pop(context);
              usersCubit.updateUserImage(source: 'camera');
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(Icons.photo_camera, size: 32.h),
                Text(
                  'من الكاميرا',
                  style: TextStyle(fontSize: 18.sp),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
