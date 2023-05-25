import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_your_dev/models/user_model.dart';
import 'custom_bottom_sheet.dart';
import 'custom_cached_image.dart';
import 'custom_icon_button.dart';

class ChooseImageWiget extends StatelessWidget {
  const ChooseImageWiget({super.key, required this.userModel});

  final UserModel? userModel;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          CustomCachedImage(
            imageUrl: userModel!.image,
            width: 120,
            height: 130,
          ),
          Positioned(
            top: 100.h,
            child: CircleAvatar(
                child: CustomIconButton(
              icon: Icons.add_a_photo,
              iconRadius: 50,
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return CustomBottomSheet(
                      defaultImage: userModel!.image,
                    );
                  },
                );
              },
            )),
          )
        ],
      ),
    );
  }
}
