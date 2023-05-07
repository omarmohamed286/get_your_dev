import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_your_dev/app/utils/constants.dart';
import 'package:get_your_dev/app/utils/helpers/dialog_helper.dart';
import 'package:get_your_dev/view_models/user_data_cubit/user_data_cubit.dart';

class CustomBottomSheet extends StatefulWidget {
  const CustomBottomSheet({super.key, required this.defaultImage});

  final String defaultImage;

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  String? pickedImage;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserDataCubit, UserDataState>(
      listener: (context, state) {
        if (state is UserDataUpdateFailure) {
          customErrorDialog(context: context, description: state.errorMessage);
        }
      },
      builder: (context, state) {
        UserDataCubit cubit = BlocProvider.of<UserDataCubit>(context);
        return Container(
          height: 130.h,
          padding: EdgeInsets.all(32.h),
          color: Constants.whiteColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () async {
                  Navigator.pop(context);
                  pickedImage = await cubit.uploadUserImage(source: 'gallery');
                  cubit.updateUser(
                      key: 'camera', value: pickedImage ?? widget.defaultImage);
                  cubit.getUser();
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
                  pickedImage = await cubit.uploadUserImage(source: 'camera');
                  cubit.updateUser(
                      key: 'camera', value: pickedImage ?? widget.defaultImage);
                  cubit.getUser();
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
      },
    );
  }
}
