import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_your_dev/app/utils/helpers/app_bar_helper.dart';
import 'package:get_your_dev/models/developer_model.dart';
import '../widgets/custom_cached_image.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

class DeveloperDetailsScreen extends StatelessWidget {
  const DeveloperDetailsScreen({super.key});

  static const id = 'developerDetailsScreen';

  Future<void> _launchUrl(String _url) async {
    if (!await launchUrl(
      Uri.parse(_url),
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  Widget build(BuildContext context) {
    DeveloperModel developerModel =
        ModalRoute.of(context)!.settings.arguments as DeveloperModel;
    return Scaffold(
      appBar: getAppBar(title: 'معلومات عن المطور'),
      body: ListView(
        padding: EdgeInsets.all(16.h),
        children: [
          Center(
            child: CustomCachedImage(
              imageUrl: developerModel.image,
              height: 125,
              width: 110,
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            developerModel.name,
            style: TextStyle(fontSize: 32.sp),
          ),
          Text(
            developerModel.field,
            style: TextStyle(fontSize: 32.sp),
          ),
          Text(developerModel.shortDescription),
          SizedBox(height: 24.h),
          Linkify(
            onOpen: (link) async {
              await _launchUrl(link.url);
            },
            text: developerModel.longDescription,
            style: TextStyle(fontSize: 28.sp),
          )
        ],
      ),
    );
  }
}
