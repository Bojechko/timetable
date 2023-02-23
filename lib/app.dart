import 'package:example_project_mobile/pages/main_page.dart';
import 'package:example_project_mobile/repositories/strange_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(StrangeRepository());
    return const MaterialApp(
      home: MainPage(),
    );
  }
}
