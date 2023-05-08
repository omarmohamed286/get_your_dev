import 'package:flutter/material.dart';
import 'package:get_your_dev/app/utils/helpers/app_bar_helper.dart';

class AddDeveloperScreen extends StatelessWidget {
  const AddDeveloperScreen({super.key});

  static const id = 'addDeveloperScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(title: 'عرض مطور'),
    );
  }
}
