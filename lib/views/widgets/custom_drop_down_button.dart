import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../view_models/drop_down_cubit/drop_down_cubit.dart';

class CustomDropDownButton extends StatefulWidget {
  const CustomDropDownButton({super.key});

  @override
  State<CustomDropDownButton> createState() => _CustomDropDownButtonState();
}

class _CustomDropDownButtonState extends State<CustomDropDownButton> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DropDownCubit, DropDownState>(
      builder: (context, state) {
        return DropdownButton(
            elevation: 24,
            borderRadius: BorderRadius.circular(12.r),
            value: BlocProvider.of<DropDownCubit>(context).dropDownValue,
            items: BlocProvider.of<DropDownCubit>(context).dropDownItems,
            onChanged: (value) {
              BlocProvider.of<DropDownCubit>(context).setDropDownValue(value);
            });
      },
    );
  }
}
