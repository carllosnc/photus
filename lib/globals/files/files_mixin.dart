import 'package:flutter/material.dart';
import './files_state.dart';

mixin FilesMixin<T extends StatefulWidget> on State<T> {
  @override
  void initState() {
    super.initState();
    files.addListener(action);
  }

  @override
  void dispose() {
    super.dispose();
    files.removeListener(action);
  }

  action() {
    setState(() {});
  }
}
