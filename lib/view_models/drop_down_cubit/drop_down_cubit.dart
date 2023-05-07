import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
part 'drop_down_state.dart';

class DropDownCubit extends Cubit<DropDownState> {
  DropDownCubit() : super(DropDownInitial());

  String dropDownValue = 'مطور';
  List<String> items = ["مطور", "أبحث عن مطور"];

  get dropDownItems => items
      .map((item) => DropdownMenuItem(value: item, child: Text(item)))
      .toList();

  void setDropDownValue(value) {
    dropDownValue = value;
    emit(DropDownInitial());
  }
}
