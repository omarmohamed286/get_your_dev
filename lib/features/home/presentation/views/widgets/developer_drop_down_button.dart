import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_your_dev/features/home/presentation/view_model/developer_drop_down_button.dart/developer_drop_down_button_cubit.dart';

class DeveloperDropDownButton extends StatelessWidget {
  const DeveloperDropDownButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeveloperDropDownButtonCubit,
        DeveloperDropDownButtonState>(
      builder: (context, state) {
        return DropdownButton(
          borderRadius: BorderRadius.circular(12),
          value: BlocProvider.of<DeveloperDropDownButtonCubit>(context)
              .developerDropDownValue,
          items: BlocProvider.of<DeveloperDropDownButtonCubit>(context)
              .developerDropDownItems,
          onChanged: (value) {
            BlocProvider.of<DeveloperDropDownButtonCubit>(context)
                .setDeveloperDropDownValue(value);
          },
        );
      },
    );
  }
}
