import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../view_models/drop_down_cubit/drop_down_cubit.dart';

class CustomDropDownButton extends StatefulWidget {
  const CustomDropDownButton({super.key, required this.keyword});

  final String keyword;

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
            value: widget.keyword == 'signup'
                ? BlocProvider.of<DropDownCubit>(context).signupDropDownValue
                : BlocProvider.of<DropDownCubit>(context)
                    .developerDropDownValue,
            items: widget.keyword == 'signup'
                ? BlocProvider.of<DropDownCubit>(context).signupDropDownItems
                : BlocProvider.of<DropDownCubit>(context)
                    .developerDropDownItems,
            onChanged: (value) {
              if (widget.keyword == 'signup') {
                BlocProvider.of<DropDownCubit>(context)
                    .setSignupDropDownValue(value);
              } else {
                BlocProvider.of<DropDownCubit>(context)
                    .setDeveloperDropDownValue(value);
              }
            });
      },
    );
  }
}
