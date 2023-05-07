import 'package:flutter/material.dart';
import '../constants.dart';

PreferredSizeWidget getAppBar({required String title}) => AppBar(
    backgroundColor: Constants.blackColor,
    title: Text(title),
    centerTitle: true);
