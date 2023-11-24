import 'package:flutter/material.dart';

appTheme() {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorSchemeSeed: Colors.blue,
    fontFamily: 'SFProDisplay',
    scaffoldBackgroundColor: Colors.black,
    sliderTheme: const SliderThemeData(
      activeTrackColor: Colors.blue,
      inactiveTrackColor: Colors.white,
      thumbColor: Colors.blue,
      trackHeight: 1,
      thumbShape: RoundSliderThumbShape(
        enabledThumbRadius: 5,
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Color.fromARGB(255, 17, 17, 17),
      surfaceTintColor: Color.fromARGB(255, 17, 17, 17),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(0),
        ),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      elevation: 0,
      surfaceTintColor: Colors.black,
    ),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );
}
