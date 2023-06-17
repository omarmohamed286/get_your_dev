import 'package:flutter/material.dart';
import '../../../../core/utils/custom_app_bar.dart';

class AddDeveloperView extends StatelessWidget {
  const AddDeveloperView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'معلومات المطور'),
    );
  }
}
