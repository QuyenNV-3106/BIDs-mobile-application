import 'package:bid_online_app_v2/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(28),
    borderSide: const BorderSide(color: kTextColor),
    gapPadding: 10,
  );
  return InputDecorationTheme(
    floatingLabelBehavior: FloatingLabelBehavior.always,
    contentPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
    enabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    border: outlineInputBorder,
  );
}

ThemeData theme() {
  return ThemeData(
    appBarTheme: appBarTheme(),
    inputDecorationTheme: inputDecorationTheme(),
    fontFamily: GoogleFonts.workSans().fontFamily,
    textTheme:
        const TextTheme(titleLarge: TextStyle(fontWeight: FontWeight.bold)),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    iconTheme: const IconThemeData(
      color: kPrimaryColor,
    ),
  );
}

AppBarTheme appBarTheme() {
  return const AppBarTheme(
    centerTitle: true,
    color: Colors.white,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(
      color: kTextColor,
      fontWeight: FontWeight.w500,
      fontSize: 20,
    ),
  );
}
