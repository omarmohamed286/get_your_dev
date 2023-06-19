import 'package:flutter/material.dart';
import '../../../../../core/constants.dart';
import '../../../../../core/utils/app_styles.dart';

class UserInfoCard extends StatelessWidget {
  const UserInfoCard(
      {super.key,
      required this.info,
      required this.infoValue,
      this.onEditPressed});

  final String info;
  final String infoValue;
  final void Function()? onEditPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        info,
        style: AppStyles.textStyle24,
      ),
      subtitle: Text(
        infoValue == 'أبحث عن مطور' ? 'يبحث عن مطور' : infoValue,
        style: AppStyles.textStyle18.copyWith(color: kBlackColor),
      ),
      trailing: onEditPressed == null
          ? null
          : TextButton(
              onPressed: onEditPressed,
              child: Text("تعديل",
                  style: AppStyles.textStyle18.copyWith(color: Colors.blue))),
    );
  }
}
