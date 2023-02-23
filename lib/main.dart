import 'package:example_project_mobile/app.dart';
import 'package:example_project_mobile/config/environment.dart';
import 'package:flutter/material.dart';
import 'pages/main_page.dart';
import 'pages/schedule_page.dart';
import 'store/store.dart';

late ObjectBox objectbox;

Future<void> main() async {
  Environment().init(host: 'release.nostress.dev', port: 1377);
  WidgetsFlutterBinding.ensureInitialized();

  objectbox = await ObjectBox.create();
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => const MainPage(),
      '/schedule': (context) => Schedudle(),
    },
  )
  );

}
