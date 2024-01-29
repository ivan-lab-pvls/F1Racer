import 'package:flutter/material.dart';

class CTheme {
  static const Color scaffoldBackgroundColor = Color(0xFF222222);
  static const Color greyColor = Color.fromRGBO(177, 177, 177, 1);
  static const Color textGreyColor = Color(0xFF7b7b7b);
  static const Color darkGreyColor = Color(0xFF343434);
  static const Color darkColor = Color(0xFF303030);
  static const Color blackColor = Color(0xFF1a1a1a);
  static const Color primaryColor = Color(0xFFd88029);
  static const Color whiteColor = Color(0xFFfcfcfc);

  static ThemeData get theme => ThemeData(
        scaffoldBackgroundColor: scaffoldBackgroundColor,
        primaryColor: primaryColor,
      );
}
