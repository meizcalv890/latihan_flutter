import 'package:get/get.dart';

import '../bindings/football_binding.dart';
import '../bindings/kalkulator_binding.dart';

import '../pages/login_page.dart';
import '../pages/home_page.dart';
import '../pages/kalkulator_page.dart';
import '../pages/calculator_history_page.dart';
import '../pages/football_page.dart';
import '../pages/football_detail_page.dart';
import '../pages/favorite_page.dart';
import '../pages/profile_page.dart';
import '../pages/settings_page.dart';

import 'routes.dart';

class Pages {
  static final pages = [
    GetPage(name: Routes.login, page: () => const LoginPage()),

    GetPage(name: Routes.home, page: () => const HomePage()),

    GetPage(
      name: Routes.kalkulator,
      page: () => const KalkulatorPage(),
      binding: KalkulatorBinding(),
    ),

    GetPage(
      name: Routes.calculatorHistory,
      page: () => const CalculatorHistoryPage(),
      binding: KalkulatorBinding(),
    ),

    GetPage(
      name: Routes.football,
      page: () => const FootballPage(),
      binding: FootballBinding(),
    ),

    GetPage(
      name: Routes.footballDetail,
      page: () => const FootballDetailPage(),
      binding: FootballBinding(),
    ),

    GetPage(
      name: Routes.favorite,
      page: () => const FavoritePage(),
      binding: FootballBinding(),
    ),

    GetPage(name: Routes.profile, page: () => const ProfilePage()),

    GetPage(name: Routes.settings, page: () => const SettingsPage()),
  ];
}
