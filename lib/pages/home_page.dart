import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../controllers/auth_controller.dart';
import '../routes/routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final auth = Get.find<AuthController>();
    final storage = GetStorage();

    final rawUsername = auth.savedUsername.trim();
    final username = rawUsername.isEmpty
        ? 'User'
        : rawUsername[0].toUpperCase() + rawUsername.substring(1);

    final history = storage.read('calculator_history') as List? ?? [];
    final favorites = storage.read('favorite_players') as List? ?? [];

    return Scaffold(
      backgroundColor: colors.surface,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            final isWide = width >= 900;
            final horizontalPadding = width >= 1200
                ? 40.0
                : width >= 600
                ? 28.0
                : 20.0;

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: 20,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1080),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(context),
                      const SizedBox(height: 34),
                      _buildHero(context, username),
                      const SizedBox(height: 28),
                      _sectionHeading(
                        context,
                        label: 'home_activity_label'.tr,
                        title: 'home_overview'.tr,
                        trailing: 'home_statistics'.tr,
                      ),
                      const SizedBox(height: 14),
                      _buildOverview(
                        context,
                        calculationCount: history.length,
                        favoriteCount: favorites.length,
                      ),
                      const SizedBox(height: 38),
                      _sectionHeading(
                        context,
                        label: 'home_workspace_label'.tr,
                        title: 'home_explore_tools'.tr,
                        trailing: 'home_tools_count'.tr,
                      ),
                      const SizedBox(height: 16),
                      _buildFeatures(context, isWide),
                      const SizedBox(height: 38),
                      _sectionHeading(
                        context,
                        label: 'home_shortcuts_label'.tr,
                        title: 'home_quick_access'.tr,
                      ),
                      const SizedBox(height: 14),
                      _buildQuickAccess(context, isWide),
                      const SizedBox(height: 36),
                      _buildFooter(context, auth),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Row(
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: colors.primary,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Text(
            'U',
            style: TextStyle(
              color: colors.onPrimary,
              fontSize: 21,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(width: 11),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'UTILITY HUB',
              style: TextStyle(
                color: colors.onSurface,
                fontSize: 15,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.1,
              ),
            ),
            Text(
              'home_header_subtitle'.tr.toUpperCase(),
              style: TextStyle(
                color: colors.onSurfaceVariant,
                fontSize: 9,
                fontWeight: FontWeight.w600,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
        const Spacer(),
        _headerButton(
          context,
          icon: Icons.person_outline_rounded,
          tooltip: 'home_profile'.tr,
          onTap: () => Get.toNamed(Routes.profile),
        ),
        const SizedBox(width: 8),
        _headerButton(
          context,
          icon: Icons.settings_outlined,
          tooltip: 'home_settings'.tr,
          onTap: () => Get.toNamed(Routes.settings),
        ),
      ],
    );
  }

  Widget _headerButton(
    BuildContext context, {
    required IconData icon,
    required String tooltip,
    required VoidCallback onTap,
  }) {
    final colors = Theme.of(context).colorScheme;

    return IconButton(
      onPressed: onTap,
      tooltip: tooltip,
      style: IconButton.styleFrom(
        backgroundColor: colors.surfaceContainer,
        foregroundColor: colors.primary,
        side: BorderSide(color: colors.outlineVariant),
        fixedSize: const Size(42, 42),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
      ),
      icon: Icon(icon, size: 20),
    );
  }

  Widget _buildHero(BuildContext context, String username) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: colors.primary,
        borderRadius: BorderRadius.circular(18),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxWidth < 480;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: colors.onPrimary.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      'home_personal_workspace'.tr.toUpperCase(),
                      style: TextStyle(
                        color: colors.onPrimary,
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.3,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '01 / 01',
                    style: TextStyle(
                      color: colors.onPrimary.withValues(alpha: 0.7),
                      fontSize: 11,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),
              Text(
                '${'home_greeting'.tr}, $username.',
                style: TextStyle(
                  color: colors.onPrimary.withValues(alpha: 0.8),
                  fontSize: compact ? 13 : 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 9),
              Text(
                'home_hero_title'.tr,
                style: TextStyle(
                  color: colors.onPrimary,
                  fontSize: compact ? 32 : 42,
                  height: 1.12,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -1.6,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                'home_hero_description'.tr,
                style: TextStyle(
                  color: colors.onPrimary.withValues(alpha: 0.78),
                  fontSize: 13,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 25),
              OutlinedButton.icon(
                onPressed: () => Get.toNamed(Routes.profile),
                icon: const Icon(Icons.arrow_outward_rounded, size: 15),
                label: Text('home_view_profile'.tr),
                style: OutlinedButton.styleFrom(
                  foregroundColor: colors.onPrimary,
                  side: BorderSide(
                    color: colors.onPrimary.withValues(alpha: 0.45),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _sectionHeading(
    BuildContext context, {
    required String label,
    required String title,
    String? trailing,
  }) {
    final colors = Theme.of(context).colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label.toUpperCase(),
                style: TextStyle(
                  color: colors.tertiary,
                  fontSize: 9,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                title,
                style: TextStyle(
                  color: colors.onSurface,
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.7,
                ),
              ),
            ],
          ),
        ),
        if (trailing != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 3),
            child: Text(
              trailing.toUpperCase(),
              style: TextStyle(
                color: colors.onSurfaceVariant,
                fontSize: 9,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.8,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildOverview(
    BuildContext context, {
    required int calculationCount,
    required int favoriteCount,
  }) {
    final colors = Theme.of(context).colorScheme;

    return Row(
      children: [
        Expanded(
          child: _statCard(
            context,
            number: calculationCount.toString(),
            label: 'home_calculations'.tr,
            icon: Icons.calculate_outlined,
            accent: colors.primary,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _statCard(
            context,
            number: favoriteCount.toString(),
            label: 'home_saved_favorites'.tr,
            icon: Icons.favorite_outline_rounded,
            accent: colors.tertiary,
          ),
        ),
      ],
    );
  }

  Widget _statCard(
    BuildContext context, {
    required String number,
    required String label,
    required IconData icon,
    required Color accent,
  }) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: colors.surfaceContainer,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: colors.outlineVariant),
      ),
      child: Row(
        children: [
          Container(
            width: 39,
            height: 39,
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.13),
              borderRadius: BorderRadius.circular(9),
            ),
            child: Icon(icon, color: accent, size: 19),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  number,
                  style: TextStyle(
                    color: colors.onSurface,
                    fontSize: 25,
                    height: 1.1,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -1,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  label.toUpperCase(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: colors.onSurfaceVariant,
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.7,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatures(BuildContext context, bool isWide) {
    final colors = Theme.of(context).colorScheme;

    final calculator = _featurePanel(
      context,
      number: '01',
      title: 'home_calculator'.tr,
      description: 'home_calculator_description'.tr,
      icon: Icons.calculate_outlined,
      accent: colors.primary,
      route: Routes.kalkulator,
    );

    final football = _featurePanel(
      context,
      number: '02',
      title: 'home_football'.tr,
      description: 'home_football_description'.tr,
      icon: Icons.sports_soccer_rounded,
      accent: colors.tertiary,
      route: Routes.football,
    );

    if (isWide) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: calculator),
          const SizedBox(width: 14),
          Expanded(child: football),
        ],
      );
    }

    return Column(children: [calculator, const SizedBox(height: 12), football]);
  }

  Widget _featurePanel(
    BuildContext context, {
    required String number,
    required String title,
    required String description,
    required IconData icon,
    required Color accent,
    required String route,
  }) {
    final colors = Theme.of(context).colorScheme;

    return Material(
      color: colors.surfaceContainer,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: () => Get.toNamed(route),
        borderRadius: BorderRadius.circular(14),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(19),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: colors.outlineVariant),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 43,
                    height: 43,
                    decoration: BoxDecoration(
                      color: accent.withValues(alpha: 0.13),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(icon, color: accent, size: 22),
                  ),
                  const Spacer(),
                  Text(
                    number,
                    style: TextStyle(
                      color: colors.onSurfaceVariant,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.arrow_outward_rounded,
                    color: colors.onSurfaceVariant,
                    size: 17,
                  ),
                ],
              ),
              const SizedBox(height: 23),
              Text(
                title,
                style: TextStyle(
                  color: colors.onSurface,
                  fontSize: 19,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 7),
              Text(
                description,
                style: TextStyle(
                  color: colors.onSurfaceVariant,
                  fontSize: 12,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 17),
              Divider(color: colors.outlineVariant, height: 1),
              const SizedBox(height: 12),
              Row(
                children: [
                  Text(
                    'home_open_tool'.tr.toUpperCase(),
                    style: TextStyle(
                      color: accent,
                      fontSize: 9,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1,
                    ),
                  ),
                  const Spacer(),
                  Icon(Icons.arrow_forward_rounded, color: accent, size: 16),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickAccess(BuildContext context, bool isWide) {
    final items = [
      _quickItem(
        context,
        icon: Icons.history_rounded,
        label: 'home_calculation_history'.tr,
        onTap: () => Get.toNamed(Routes.calculatorHistory),
      ),
      _quickItem(
        context,
        icon: Icons.favorite_border_rounded,
        label: 'home_favorite_players'.tr,
        onTap: () => Get.toNamed(Routes.favorite),
      ),
      _quickItem(
        context,
        icon: Icons.settings_outlined,
        label: 'home_preferences'.tr,
        onTap: () => Get.toNamed(Routes.settings),
      ),
    ];

    if (isWide) {
      return Row(
        children: [
          for (int i = 0; i < items.length; i++) ...[
            Expanded(child: items[i]),
            if (i != items.length - 1) const SizedBox(width: 10),
          ],
        ],
      );
    }

    return Column(
      children: [
        for (int i = 0; i < items.length; i++) ...[
          items[i],
          if (i != items.length - 1) const SizedBox(height: 8),
        ],
      ],
    );
  }

  Widget _quickItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    final colors = Theme.of(context).colorScheme;

    return Material(
      color: colors.surfaceContainer,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: colors.outlineVariant),
          ),
          child: Row(
            children: [
              Icon(icon, color: colors.tertiary, size: 19),
              const SizedBox(width: 11),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    color: colors.onSurface,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: colors.onSurfaceVariant,
                size: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFooter(BuildContext context, AuthController auth) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.only(top: 17),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: colors.outlineVariant)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'home_footer'.tr.toUpperCase(),
              style: TextStyle(
                color: colors.onSurfaceVariant,
                fontSize: 9,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.8,
              ),
            ),
          ),
          TextButton.icon(
            onPressed: () => _confirmLogout(auth),
            icon: const Icon(Icons.logout_rounded, size: 15),
            label: Text('logout'.tr),
            style: TextButton.styleFrom(
              foregroundColor: colors.error,
              textStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _confirmLogout(AuthController auth) {
    Get.dialog(
      AlertDialog(
        title: Text('logout'.tr),
        content: Text('home_logout_confirmation'.tr),
        actions: [
          TextButton(onPressed: Get.back, child: Text('cancel'.tr)),
          TextButton(
            onPressed: () {
              Get.back();
              auth.logout();
            },
            child: Text(
              'logout'.tr,
              style: TextStyle(
                color: Theme.of(Get.context!).colorScheme.error,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
