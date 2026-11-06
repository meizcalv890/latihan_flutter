import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/football_ctr.dart';
import '../models/football_model.dart';
import '../widgets/player_form_dialog.dart';

class FootballDetailPage extends StatelessWidget {
  const FootballDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final initialPlayer = Get.arguments as FootballModel;
    final controller = Get.find<FootballCtr>();
    final currentPlayer = initialPlayer.obs;
    final colors = Theme.of(context).colorScheme;

    void editPlayer() {
      Get.dialog(
        PlayerFormDialog(
          initialPlayer: currentPlayer.value,
          onSave: (updatedPlayer) {
            controller.updatePlayer(updatedPlayer);
            currentPlayer.value = updatedPlayer;
          },
        ),
      );
    }

    void deletePlayer() {
      Get.dialog(
        AlertDialog(
          backgroundColor: colors.surface,
          title: Text(
            'football_delete_title'.tr,
            style: TextStyle(color: colors.onSurface),
          ),
          content: Text(
            '${'football_delete_confirmation'.tr}\n\n'
            '${currentPlayer.value.name}',
            style: TextStyle(color: colors.onSurfaceVariant),
          ),
          actions: [
            TextButton(onPressed: Get.back, child: Text('cancel'.tr)),
            ElevatedButton(
              onPressed: () {
                controller.deletePlayer(currentPlayer.value.id);
                Get.back();
                Get.back();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.error,
                foregroundColor: colors.onError,
              ),
              child: Text('delete'.tr),
            ),
          ],
        ),
      );
    }

    return Obx(() {
      final player = currentPlayer.value;

      return Scaffold(
        backgroundColor: colors.surface,
        appBar: AppBar(
          title: Text('football_detail_title'.tr),
          backgroundColor: colors.surface,
          foregroundColor: colors.onSurface,
          actions: [
            if (player.isCustom)
              PopupMenuButton<String>(
                iconColor: colors.onSurface,
                onSelected: (value) {
                  if (value == 'edit') editPlayer();
                  if (value == 'delete') deletePlayer();
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'edit',
                    child: ListTile(
                      leading: const Icon(Icons.edit_outlined),
                      title: Text('football_edit_player'.tr),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                  PopupMenuItem(
                    value: 'delete',
                    child: ListTile(
                      leading: Icon(Icons.delete_outline, color: colors.error),
                      title: Text(
                        'football_delete_player'.tr,
                        style: TextStyle(color: colors.error),
                      ),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ],
              ),
            Obx(() {
              final favorite = controller.isFavorite(player.name);

              return IconButton(
                tooltip: favorite
                    ? 'football_remove_favorite'.tr
                    : 'football_add_favorite'.tr,
                onPressed: () {
                  controller.toggleFavorite(player.name);
                },
                icon: Icon(
                  favorite
                      ? Icons.favorite_rounded
                      : Icons.favorite_border_rounded,
                  color: favorite ? colors.error : colors.onSurface,
                ),
              );
            }),
            const SizedBox(width: 8),
          ],
        ),
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 850),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildPlayerHero(player, colors),
                  const SizedBox(height: 28),

                  Text(
                    'football_profile'.tr,
                    style: TextStyle(
                      color: colors.primary,
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.5,
                    ),
                  ),

                  const SizedBox(height: 14),

                  _buildInformationGrid(player, colors),

                  const SizedBox(height: 28),

                  Text(
                    'football_about'.tr,
                    style: TextStyle(
                      color: colors.onSurface,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(19),
                    decoration: BoxDecoration(
                      color: colors.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: colors.outlineVariant),
                    ),
                    child: Text(
                      player.description,
                      style: TextStyle(
                        color: colors.onSurfaceVariant,
                        fontSize: 13,
                        height: 1.8,
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton.icon(
                      onPressed: Get.back,
                      icon: const Icon(Icons.arrow_back_rounded, size: 18),
                      label: Text('football_back'.tr),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colors.primary,
                        foregroundColor: colors.onPrimary,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildPlayerHero(FootballModel player, ColorScheme colors) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(26),
      decoration: BoxDecoration(
        color: colors.primary,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        children: [
          Container(
            width: 94,
            height: 94,
            decoration: BoxDecoration(
              color: colors.secondaryContainer,
              borderRadius: BorderRadius.circular(27),
            ),
            child: Center(
              child: Text(
                player.name.isNotEmpty ? player.name[0].toUpperCase() : '?',
                style: TextStyle(
                  color: colors.onSecondaryContainer,
                  fontSize: 42,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),

          const SizedBox(height: 21),

          Text(
            player.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: colors.onPrimary,
              fontSize: 26,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.7,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            player.team,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: colors.onPrimary.withValues(alpha: 0.75),
              fontSize: 14,
            ),
          ),

          const SizedBox(height: 19),

          Wrap(
            alignment: WrapAlignment.center,
            spacing: 8,
            runSpacing: 8,
            children: [
              _heroTag(player.position.toUpperCase(), colors),
              _heroTag(player.country.toUpperCase(), colors),
              _heroTag('NO. ${player.number}', colors),
            ],
          ),
        ],
      ),
    );
  }

  Widget _heroTag(String label, ColorScheme colors) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: colors.onPrimary.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: colors.onPrimary.withValues(alpha: 0.15)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: colors.onPrimary,
          fontSize: 9,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.8,
        ),
      ),
    );
  }

  Widget _buildInformationGrid(FootballModel player, ColorScheme colors) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth >= 550 ? 2 : 1;

        return GridView.count(
          crossAxisCount: columns,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: columns == 2 ? 3.2 : 4.2,
          children: [
            _infoTile(
              Icons.sports_soccer_rounded,
              'football_position'.tr,
              player.position,
              colors,
            ),
            _infoTile(
              Icons.flag_outlined,
              'football_country'.tr,
              player.country,
              colors,
            ),
            _infoTile(
              Icons.numbers_rounded,
              'football_number'.tr,
              '#${player.number}',
              colors,
            ),
            _infoTile(
              Icons.shield_outlined,
              'football_club'.tr,
              player.team,
              colors,
            ),
          ],
        );
      },
    );
  }

  Widget _infoTile(
    IconData icon,
    String title,
    String value,
    ColorScheme colors,
  ) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colors.outlineVariant),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: colors.secondaryContainer,
              borderRadius: BorderRadius.circular(11),
            ),
            child: Icon(icon, color: colors.onSecondaryContainer, size: 19),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title.toUpperCase(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: colors.onSurfaceVariant,
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: colors.onSurface,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
