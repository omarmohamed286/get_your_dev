import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants.dart';

class CustomCachedImage extends StatelessWidget {
  const CustomCachedImage(
      {super.key,
      required this.imageUrl,
      required this.width,
      required this.height});

  final String imageUrl;
  final int width;
  final int height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width.w,
      height: height.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(70.r),
        color: kWhiteColor,
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
