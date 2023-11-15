import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/app.dart';
import '/imports/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await sharedPreferences.loadPreferences();

  runApp(const App());
}
