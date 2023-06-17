import 'package:flutter/material.dart';
import '../constants.dart';

OutlineInputBorder customBorder() => const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(12)),
    borderSide: BorderSide(color: kBlackColor));
