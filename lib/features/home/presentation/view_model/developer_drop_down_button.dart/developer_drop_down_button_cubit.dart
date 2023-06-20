import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'developer_drop_down_button_state.dart';

class DeveloperDropDownButtonCubit extends Cubit<DeveloperDropDownButtonState> {
  DeveloperDropDownButtonCubit() : super(DeveloperDropDownButtonInitial());

  String developerDropDownValue = 'مطور فرونت اند';
  List<String> developerItems = [
    'مطور فرونت اند',
    'مطور باك اند',
    'مطور فل ستاك',
    'مطور موبايل اندرويد',
    'مطور موبايل IOS',
    'مطور فلاتر'
  ];

  get developerDropDownItems => developerItems
      .map((item) => DropdownMenuItem(value: item, child: Text(item)))
      .toList();

  void setDeveloperDropDownValue(value) {
    developerDropDownValue = value;
    emit(DeveloperDropDownButtonInitial());
  }
}
