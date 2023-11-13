import 'package:flutter/material.dart';

var basicTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorSchemeSeed: Colors.red,
  fontFamily: 'SFProDisplay',
  scaffoldBackgroundColor: Colors.black,
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: Color.fromARGB(255, 17, 17, 17),
    surfaceTintColor: Color.fromARGB(255, 17, 17, 17),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(0),
      ),
    ),
  ),
  iconTheme: const IconThemeData(
    color: Colors.white,
    opacity: 1,
    size: 21,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black,
    elevation: 0,
    surfaceTintColor: Colors.black,
    iconTheme: IconThemeData(
      color: Colors.white,
      opacity: 1,
      size: 21,
    ),
  ),
  listTileTheme: const ListTileThemeData(
    iconColor: Colors.white,
    titleTextStyle: TextStyle(
      color: Colors.white,
    ),
  ),
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
  ),
);
