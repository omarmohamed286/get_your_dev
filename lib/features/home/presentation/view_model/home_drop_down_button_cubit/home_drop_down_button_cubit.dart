import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'home_drop_down_button_state.dart';

class HomeDropDownButtonCubit extends Cubit<HomeDropDownButtonState> {
  HomeDropDownButtonCubit() : super(HomeDropDownButtonInitial());

  String homeDropDownValue = 'الكل';
  List<String> homeItems = [
    'الكل',
    'مطور فرونت اند',
    'مطور باك اند',
    'مطور فل ستاك',
    'مطور موبايل اندرويد',
    'مطور موبايل IOS',
    'مطور فلاتر'
  ];

  get homeDropDownItems => homeItems
      .map((item) => DropdownMenuItem(value: item, child: Text(item)))
      .toList();

  void setHomeDropDownValue(value) {
    homeDropDownValue = value;
    emit(HomeDropDownButtonInitial());
  }
}
