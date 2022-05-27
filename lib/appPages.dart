import 'package:get/get.dart';
import 'package:to_do_app/view-model/bindings/splashBinding.dart';
import 'package:to_do_app/view/home_page/home_page.dart';
import 'package:to_do_app/view/screens/splashScreen.dart';

class AppPages {
  static const initial = Routes.splash;

  static final routes = [
    GetPage(
      name: Routes.splash,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
      transition: Transition.native,
      transitionDuration: const Duration(milliseconds: 1000),
    ),
    GetPage(
      name: Routes.home,
      page: () => const HomePage(),
      transition: Transition.native,
      transitionDuration: const Duration(milliseconds: 1000),
    ),
  ];
}






abstract class Routes {
  static const splash = '/splash';
  static const home = '/home';
}
