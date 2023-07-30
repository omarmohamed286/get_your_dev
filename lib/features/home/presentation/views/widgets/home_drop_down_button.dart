import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_your_dev/features/home/presentation/view_model/home_drop_down_button_cubit/home_drop_down_button_cubit.dart';
import 'package:get_your_dev/features/home/presentation/view_model/user_data_cubit/user_data_cubit.dart';

class HomeDropDownButton extends StatelessWidget {
  const HomeDropDownButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeDropDownButtonCubit, HomeDropDownButtonState>(
      builder: (context, state) {
        return DropdownButton(
          borderRadius: BorderRadius.circular(12),
          value: BlocProvider.of<HomeDropDownButtonCubit>(context)
              .homeDropDownValue,
          items: BlocProvider.of<HomeDropDownButtonCubit>(context)
              .homeDropDownItems,
          onChanged: (value) {
            BlocProvider.of<HomeDropDownButtonCubit>(context)
                .setHomeDropDownValue(value);
            BlocProvider.of<UserDataCubit>(context).getSpecificFieldDevelopers(
                field: BlocProvider.of<HomeDropDownButtonCubit>(context)
                    .homeDropDownValue);
          },
        );
      },
    );
  }
}
