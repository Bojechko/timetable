import 'package:example_project_mobile/app.dart';
import 'package:example_project_mobile/config/environment.dart';
import 'package:flutter/material.dart';

void main() {
  Environment().init(host: 'test.nostress.dev', port: 1337);
  runApp(const App());
}
