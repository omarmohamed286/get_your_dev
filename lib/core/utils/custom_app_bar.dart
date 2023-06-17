import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants.dart';

PreferredSizeWidget customAppBar({required String title}) => AppBar(
    backgroundColor: kBlackColor,
    title: Text(
      title,
      style: GoogleFonts.tajawal(),
    ),
    centerTitle: true);
