import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  final GetStorage storage = GetStorage();

  final Rx<ThemeMode> themeMode = ThemeMode.system.obs;
  final Rx<Locale> locale = const Locale('en', 'US').obs;

  @override
  void onInit() {
    super.onInit();
    loadPreferences();
  }

  void loadPreferences() {
    final savedTheme = storage.read<String>('app_theme');

    switch (savedTheme) {
      case 'light':
        themeMode.value = ThemeMode.light;
        break;
      case 'dark':
        themeMode.value = ThemeMode.dark;
        break;
      default:
        themeMode.value = ThemeMode.system;
    }

    final savedLanguage = storage.read<String>('app_language');

    locale.value = savedLanguage == 'id'
        ? const Locale('id', 'ID')
        : const Locale('en', 'US');
  }

  void changeTheme(String value) {
    switch (value) {
      case 'light':
        themeMode.value = ThemeMode.light;
        break;
      case 'dark':
        themeMode.value = ThemeMode.dark;
        break;
      default:
        themeMode.value = ThemeMode.system;
    }

    storage.write('app_theme', value);
  }

  String get selectedTheme {
    switch (themeMode.value) {
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
      case ThemeMode.system:
        return 'system';
    }
  }

  void changeLanguage(String languageCode) {
    final newLocale = languageCode == 'id'
        ? const Locale('id', 'ID')
        : const Locale('en', 'US');

    locale.value = newLocale;
    Get.updateLocale(newLocale);

    storage.write('app_language', languageCode);
  }

  String get selectedLanguage => locale.value.languageCode;
}
