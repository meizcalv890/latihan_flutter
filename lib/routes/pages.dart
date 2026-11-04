import 'package:get/get.dart';
import 'package:latihan_flutter/bindings/football_binding.dart';
import 'package:latihan_flutter/bindings/kalkulator_binding.dart';
import 'package:latihan_flutter/pages/football_page.dart';
import 'package:latihan_flutter/pages/kalkulator_page.dart';
import 'package:latihan_flutter/pages/login_page.dart';
import 'package:latihan_flutter/routes/routes.dart';
import 'package:latihan_flutter/pages/home_page.dart';

class Pages {
  static final pages = [
    GetPage(
      name: Routes.login,
      page: () => const LoginPage()
    ),
    GetPage(
      name: Routes.home,
      page: () => const HomePage()
    ),
    GetPage(
      name: Routes.kalkulator,
      page: () => const KalkulatorPage(),
      binding: KalkulatorBinding(),
    ),
    GetPage(
      name: Routes.football,
      page: () => const FootballPage(),
      binding: FootballBinding(),
    ),
  ];
}
