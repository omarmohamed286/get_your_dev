import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../app/utils/constants.dart';

class CustomCachedImage extends StatelessWidget {
  const CustomCachedImage({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120.w,
      height: 135.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(70.r),
        color: Constants.whiteColor,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(70.r),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          placeholder: (context, url) => Center(
            child: SizedBox(
              width: 45.w,
              height: 45.h,
              child: const CircularProgressIndicator(),
            ),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}
