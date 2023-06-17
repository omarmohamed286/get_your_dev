import 'package:flutter/material.dart';
import 'package:get_your_dev/core/utils/custom_app_bar.dart';

class UserInformationsView extends StatelessWidget {
  const UserInformationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'معلومات المستخدم'),
    );
  }
}
