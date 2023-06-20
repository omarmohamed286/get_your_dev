import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get_your_dev/core/models/user_model.dart';
import 'package:get_your_dev/core/utils/app_styles.dart';
import 'package:get_your_dev/core/utils/custom_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'widgets/custom_cached_image.dart';

class DeveloperDetailsView extends StatelessWidget {
  const DeveloperDetailsView({super.key});

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
    UserModel developer =
        ModalRoute.of(context)!.settings.arguments as UserModel;
    return Scaffold(
      appBar: customAppBar(title: 'معلومات عن المطور'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: CustomCachedImage(
              imageUrl: developer.image,
              height: 125,
              width: 110,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            developer.username,
            style: AppStyles.textStyle32,
          ),
          Text(
            developer.field!,
            style: AppStyles.textStyle32,
          ),
          Text(developer.shortDescription!),
          const SizedBox(height: 24),
          Linkify(
            onOpen: (link) async {
              await _launchUrl(link.url);
            },
            text: developer.longDescription!,
            style: AppStyles.textStyle24,
          )
        ],
      ),
    );
  }
}
