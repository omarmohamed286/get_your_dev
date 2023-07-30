import 'package:flutter/material.dart';
import '../../../../../core/utils/app_styles.dart';
import 'home_drop_down_button.dart';

class ChooseFieldSection extends StatelessWidget {
  const ChooseFieldSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'ابحث عن:',
          style: AppStyles.textStyle24,
        ),
        const SizedBox(width: 5),
        const HomeDropDownButton()
      ],
    );
  }
}
