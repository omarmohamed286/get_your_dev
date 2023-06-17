import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../view_model/drop_down_button_cubit/drop_down_button_cubit.dart';

class CustomDropDownButton extends StatelessWidget {
  const CustomDropDownButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DropDownButtonCubit, DropDownButtonState>(
      builder: (context, state) {
        return DropdownButton(
          borderRadius: BorderRadius.circular(12),
          value:
              BlocProvider.of<DropDownButtonCubit>(context).signupDropDownValue,
          items:
              BlocProvider.of<DropDownButtonCubit>(context).signupDropDownItems,
          onChanged: (value) {
            BlocProvider.of<DropDownButtonCubit>(context)
                .setSignupDropDownValue(value);
          },
        );
      },
    );
  }
}
