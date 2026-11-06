import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../controllers/auth_controller.dart';
import '../controllers/kalkulator_controller.dart';
import '../controllers/football_ctr.dart';
import '../controllers/theme_controller.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final GetStorage storage = GetStorage();
  final ThemeController themeController = Get.find<ThemeController>();

  bool notifications = true;

  @override
  void initState() {
    super.initState();
    notifications = storage.read('notifications') ?? true;
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: Text('settings'.tr)),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 760),
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              _sectionHeader('preferences'.tr, 'preferences_description'.tr),
              const SizedBox(height: 14),

              _settingsContainer(
                child: SwitchListTile(
                  value: notifications,
                  onChanged: (value) {
                    setState(() => notifications = value);
                    storage.write('notifications', value);
                  },
                  secondary: const _SettingsIcon(
                    icon: Icons.notifications_none_rounded,
                  ),
                  title: Text(
                    'notifications'.tr,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                  subtitle: Text(
                    'notifications_description'.tr,
                    style: TextStyle(
                      color: colors.onSurfaceVariant,
                      fontSize: 12,
                    ),
                  ),
                  activeThumbColor: colors.primary,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 7,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              _settingsContainer(
                child: Obx(
                  () => ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    leading: const _SettingsIcon(icon: Icons.palette_outlined),
                    title: Text(
                      'appearance'.tr,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                    subtitle: Text(
                      '${'theme'.tr}: ${_themeLabel(themeController.selectedTheme)}',
                      style: TextStyle(
                        color: colors.onSurfaceVariant,
                        fontSize: 12,
                      ),
                    ),
                    trailing: const Icon(Icons.chevron_right_rounded),
                    onTap: showThemePicker,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              _settingsContainer(
                child: Obx(
                  () => ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    leading: const _SettingsIcon(icon: Icons.language_rounded),
                    title: Text(
                      'language'.tr,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                    subtitle: Text(
                      themeController.selectedLanguage == 'id'
                          ? 'language_indonesian'.tr
                          : 'language_english'.tr,
                      style: TextStyle(
                        color: colors.onSurfaceVariant,
                        fontSize: 12,
                      ),
                    ),
                    trailing: const Icon(Icons.chevron_right_rounded),
                    onTap: showLanguagePicker,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              _sectionHeader(
                'data_management'.tr,
                'data_management_description'.tr,
              ),
              const SizedBox(height: 14),

              _settingsContainer(
                child: Column(
                  children: [
                    _SettingsActionTile(
                      icon: Icons.calculate_outlined,
                      title: 'clear_history'.tr,
                      subtitle: 'clear_history_description'.tr,
                      onTap: clearCalculatorHistory,
                    ),
                    const Divider(height: 1, indent: 70, endIndent: 16),
                    _SettingsActionTile(
                      icon: Icons.favorite_border_rounded,
                      title: 'clear_favorites'.tr,
                      subtitle: 'clear_favorites_description'.tr,
                      onTap: clearFavorites,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              _sectionHeader('about'.tr, 'about_description'.tr),
              const SizedBox(height: 14),

              _settingsContainer(
                child: ListTile(
                  contentPadding: const EdgeInsets.all(17),
                  leading: const _SettingsIcon(icon: Icons.apps_rounded),
                  title: const Text(
                    'Utility Hub',
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      'version'.tr,
                      style: TextStyle(
                        color: colors.onSurfaceVariant,
                        fontSize: 12,
                        height: 1.6,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              _sectionHeader('session'.tr, 'session_description'.tr),
              const SizedBox(height: 14),

              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: confirmLogout,
                  icon: const Icon(Icons.logout_rounded),
                  label: Text('logout'.tr),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: colors.error,
                    side: BorderSide(color: colors.error),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              Center(
                child: Text(
                  'made_with_flutter'.tr,
                  style: TextStyle(
                    color: colors.onSurfaceVariant,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  String _themeLabel(String theme) {
    switch (theme) {
      case 'light':
        return 'light'.tr;
      case 'dark':
        return 'dark'.tr;
      default:
        return 'system'.tr;
    }
  }

  void showThemePicker() {
    Get.dialog(
      AlertDialog(
        title: Text('appearance'.tr),
        content: Obx(
          () => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _themeOption('system', 'system'.tr),
              _themeOption('light', 'light'.tr),
              _themeOption('dark', 'dark'.tr),
            ],
          ),
        ),
      ),
    );
  }

  Widget _themeOption(String value, String label) {
    final selected = themeController.selectedTheme == value;

    return ListTile(
      title: Text(label),
      trailing: selected
          ? const Icon(Icons.check_circle_rounded)
          : const Icon(Icons.circle_outlined),
      onTap: () {
        themeController.changeTheme(value);
        Get.back();
      },
    );
  }

  void showLanguagePicker() {
    Get.dialog(
      AlertDialog(
        title: Text('language'.tr),
        content: Obx(
          () => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _languageOption('id', 'language_indonesian'.tr),
              _languageOption('en', 'language_english'.tr),
            ],
          ),
        ),
      ),
    );
  }

  Widget _languageOption(String code, String label) {
    final selected = themeController.selectedLanguage == code;

    return ListTile(
      title: Text(label),
      trailing: selected
          ? const Icon(Icons.check_circle_rounded)
          : const Icon(Icons.circle_outlined),
      onTap: () {
        themeController.changeLanguage(code);
        Get.back();
      },
    );
  }

  Widget _sectionHeader(String title, String subtitle) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: colors.onSurface,
            fontSize: 19,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          subtitle,
          style: TextStyle(
            color: colors.onSurfaceVariant,
            fontSize: 12,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _settingsContainer({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: child,
    );
  }

  void confirmLogout() {
    Get.dialog(
      AlertDialog(
        title: Text('logout_title'.tr),
        content: Text('logout_description'.tr),
        actions: [
          TextButton(onPressed: Get.back, child: Text('cancel'.tr)),
          TextButton(
            onPressed: () {
              Get.back();
              Get.find<AuthController>().logout();
            },
            child: Text(
              'logout'.tr,
              style: TextStyle(
                color: Theme.of(context).colorScheme.error,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void clearCalculatorHistory() {
    Get.dialog(
      AlertDialog(
        title: Text('clear_history_title'.tr),
        content: Text('clear_history_confirmation'.tr),
        actions: [
          TextButton(onPressed: Get.back, child: Text('cancel'.tr)),
          TextButton(
            onPressed: () {
              if (Get.isRegistered<KalkulatorController>()) {
                Get.find<KalkulatorController>().clearHistory();
              } else {
                storage.remove('calculator_history');
              }

              Get.back();

              Get.snackbar(
                'success'.tr,
                'history_deleted'.tr,
                snackPosition: SnackPosition.BOTTOM,
              );
            },
            child: Text('delete'.tr),
          ),
        ],
      ),
    );
  }

  void clearFavorites() {
    Get.dialog(
      AlertDialog(
        title: Text('clear_favorites_title'.tr),
        content: Text('clear_favorites_confirmation'.tr),
        actions: [
          TextButton(onPressed: Get.back, child: Text('cancel'.tr)),
          TextButton(
            onPressed: () {
              if (Get.isRegistered<FootballCtr>()) {
                Get.find<FootballCtr>().favoriteNames.clear();
              }

              storage.remove('favorite_players');

              Get.back();

              Get.snackbar(
                'success'.tr,
                'favorites_deleted'.tr,
                snackPosition: SnackPosition.BOTTOM,
              );
            },
            child: Text('delete'.tr),
          ),
        ],
      ),
    );
  }
}

class _SettingsIcon extends StatelessWidget {
  final IconData icon;

  const _SettingsIcon({required this.icon});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: colors.primaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, color: colors.onPrimaryContainer, size: 21),
    );
  }
}

class _SettingsActionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _SettingsActionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
      leading: _SettingsIcon(icon: icon),
      title: Text(
        title,
        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Text(
          subtitle,
          style: TextStyle(color: colors.onSurfaceVariant, fontSize: 11),
        ),
      ),
      trailing: const Icon(Icons.chevron_right_rounded),
    );
  }
}
