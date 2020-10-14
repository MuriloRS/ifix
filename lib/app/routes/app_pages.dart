import 'package:get/get.dart';
import 'package:ifix/app/ui/pages/home_page/home_page.dart';
import 'package:ifix/app/ui/pages/signup_page/signup_page.dart';
part './app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.SIGNUP,
      page: () => Signup(),
    ),
    GetPage(name: Routes.HOME, page: () => HomePage()),
  ];
}
