import 'package:flutter/material.dart';

import '../../../../../core/models/user_model.dart';
import 'custom_bottom_sheet.dart';
import 'custom_cached_image.dart';
import 'upload_photo_button.dart';

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
            width: 140,
            height: 130,
          ),
          Positioned(
            top: 115,
            child: CircleAvatar(
                child: UploadPhotoButton(
              icon: Icons.add_a_photo,
              iconRadius: 50,
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return const CustomBottomSheet();
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
