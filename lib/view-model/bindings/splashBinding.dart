import 'package:get/get.dart';
import 'package:to_do_app/view-model/controller/homeController.dart';

import '../controller/splashController.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SplashController>(SplashController());
    Get.put<HomeController>(HomeController(), permanent: true);
  }
}
