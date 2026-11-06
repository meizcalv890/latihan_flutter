import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/football_ctr.dart';
import '../pages/football_page.dart';

class FavoritePage extends GetView<FootballCtr> {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colors.surface,
      appBar: AppBar(
        title: Text('football_favorites_title'.tr),
        backgroundColor: colors.surface,
        foregroundColor: colors.onSurface,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 950),
          child: Obx(() {
            final favorites = controller.favoritePlayers;

            if (favorites.isEmpty) {
              return _buildEmptyState(colors);
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(22, 20, 22, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'football_collection'.tr,
                        style: TextStyle(
                          color: colors.primary,
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 11),
                      Text(
                        'football_favorites_title'.tr,
                        style: TextStyle(
                          color: colors.onSurface,
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.8,
                        ),
                      ),
                      const SizedBox(height: 7),
                      Text(
                        '${favorites.length} '
                        '${favorites.length == 1 ? 'football_saved_player'.tr : 'football_saved_players'.tr}',
                        style: TextStyle(
                          color: colors.onSurfaceVariant,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final columns = constraints.maxWidth >= 650 ? 2 : 1;

                      return GridView.builder(
                        padding: const EdgeInsets.fromLTRB(22, 0, 22, 24),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: columns,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          mainAxisExtent: 116,
                        ),
                        itemCount: favorites.length,
                        itemBuilder: (context, index) {
                          return FootballPlayerCard(
                            player: favorites[index],
                            controller: controller,
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildEmptyState(ColorScheme colors) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 82,
              height: 82,
              decoration: BoxDecoration(
                color: colors.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Icon(
                Icons.favorite_border_rounded,
                color: colors.onSurfaceVariant,
                size: 38,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'football_no_favorites'.tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: colors.onSurface,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'football_no_favorites_description'.tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: colors.onSurfaceVariant,
                fontSize: 13,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 18),
            OutlinedButton.icon(
              onPressed: Get.back,
              icon: const Icon(Icons.explore_outlined),
              label: Text('football_explore'.tr),
              style: OutlinedButton.styleFrom(foregroundColor: colors.primary),
            ),
          ],
        ),
      ),
    );
  }
}
