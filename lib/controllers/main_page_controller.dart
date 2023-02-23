import 'package:example_project_mobile/config/environment.dart';
//import 'package:example_project_mobile/repositories/strange_repository.dart';
import 'package:get/get.dart';

class MainPageController extends GetxController {
  final uri = ''.obs;

 // final StrangeRepository _strangeRepository = Get.find();

  Future<void> load() async {
  //  uri.value = '[${await _strangeRepository.getStuff()}] '
    //    '${Environment().host}:${Environment().port}';
  }
}
