import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'drop_down_button_state.dart';

class DropDownButtonCubit extends Cubit<DropDownButtonState> {
  DropDownButtonCubit() : super(DropDownButtonInitial());

  String signupDropDownValue = 'مطور';
  List<String> signupItems = ["مطور", "أبحث عن مطور"];

  get signupDropDownItems => signupItems
      .map((item) => DropdownMenuItem(value: item, child: Text(item)))
      .toList();

  void setSignupDropDownValue(value) {
    signupDropDownValue = value;
    emit(DropDownButtonInitial());
  }
}
