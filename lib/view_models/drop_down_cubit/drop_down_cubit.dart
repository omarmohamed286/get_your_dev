import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
part 'drop_down_state.dart';

class DropDownCubit extends Cubit<DropDownState> {
  DropDownCubit() : super(DropDownInitial());

  String signupDropDownValue = 'مطور';
  List<String> signupItems = ["مطور", "أبحث عن مطور"];
  String developerDropDownValue = 'مطور فرونت اند';
  List<String> developerItems = [
    'مطور فرونت اند',
    'مطور باك اند',
    'مطور فل ستاك',
    'مطور موبايل اندرويد',
    'مطور موبايل IOS',
    'مطور فلاتر'
  ];

  get signupDropDownItems => signupItems
      .map((item) => DropdownMenuItem(value: item, child: Text(item)))
      .toList();

  get developerDropDownItems => developerItems
      .map((item) => DropdownMenuItem(value: item, child: Text(item)))
      .toList();

  void setSignupDropDownValue(value) {
    signupDropDownValue = value;
    emit(DropDownInitial());
  }

  void setDeveloperDropDownValue(value) {
    developerDropDownValue = value;
    print(developerDropDownValue);
    emit(DropDownInitial());
  }
}
