import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'controllers/auth_controller.dart';
import 'controllers/theme_controller.dart';
import 'routes/pages.dart';
import 'routes/routes.dart';
import 'theme/app_theme.dart';
import 'translations/app_translations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();

  Get.put(AuthController(), permanent: true);
  Get.put(ThemeController(), permanent: true);

  final authController = Get.find<AuthController>();

  runApp(
    UtilityHubApp(
      initialRoute: authController.isLoggedIn ? Routes.home : Routes.login,
    ),
  );
}

class UtilityHubApp extends StatelessWidget {
  final String initialRoute;

  const UtilityHubApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    final settings = Get.find<ThemeController>();

    return Obx(
      () => GetMaterialApp(
        title: 'Utility Hub',
        debugShowCheckedModeBanner: false,

        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: settings.themeMode.value,

        translations: AppTranslations(),
        locale: settings.locale.value,
        fallbackLocale: const Locale('en', 'US'),

        initialRoute: initialRoute,
        getPages: Pages.pages,

        defaultTransition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 250),
      ),
    );
  }
}
