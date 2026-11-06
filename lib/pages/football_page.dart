import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/football_ctr.dart';
import '../models/football_model.dart';
import '../routes/routes.dart';
import '../widgets/player_form_dialog.dart';

class FootballPage extends GetView<FootballCtr> {
  const FootballPage({super.key});

  void _showAddPlayerDialog() {
    Get.dialog(PlayerFormDialog(onSave: controller.addPlayer));
  }

  String _positionLabel(String position) {
    switch (position.toLowerCase()) {
      case 'all':
      case 'all positions':
        return 'football_all_positions'.tr;
      case 'forward':
        return 'football_forward'.tr;
      case 'midfielder':
        return 'football_midfielder'.tr;
      case 'defender':
        return 'football_defender'.tr;
      case 'goalkeeper':
        return 'football_goalkeeper'.tr;
      default:
        return position;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('football_title'.tr),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: colors.onSurface,
        actions: [
          IconButton(
            tooltip: 'football_favorites_title'.tr,
            onPressed: () => Get.toNamed(Routes.favorite),
            icon: const Icon(Icons.favorite_border_rounded),
          ),
          const SizedBox(width: 8),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddPlayerDialog,
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
        icon: const Icon(Icons.person_add_alt_1_rounded),
        label: Text('football_add_player'.tr),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1050),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(22, 12, 22, 18),
                    child: _buildHeader(context, colors),
                  ),
                  Expanded(
                    child: Obx(() {
                      final players = controller.players;

                      if (players.isEmpty) {
                        return _buildEmptySearch(context, colors);
                      }

                      final columns = constraints.maxWidth >= 700 ? 2 : 1;

                      return GridView.builder(
                        padding: const EdgeInsets.fromLTRB(22, 0, 22, 90),
                        gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: columns,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          mainAxisExtent: 116,
                        ),
                        itemCount: players.length,
                        itemBuilder: (context, index) {
                          return FootballPlayerCard(
                            player: players[index],
                            controller: controller,
                          );
                        },
                      );
                    }),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ColorScheme colors) {
    final isIndonesian = Get.locale?.languageCode == 'id';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'SPORTS / DIRECTORY',
          style: TextStyle(
            color: colors.primary,
            fontSize: 10,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'football_title'.tr,
          style: TextStyle(
            color: colors.onSurface,
            fontSize: 30,
            fontWeight: FontWeight.w800,
            letterSpacing: -1,
          ),
        ),
        const SizedBox(height: 7),
        Text(
          isIndonesian
              ? 'Jelajahi pemain, klub, dan tim nasional.'
              : 'Explore players, clubs, and national teams.',
          style: TextStyle(
            color: colors.onSurfaceVariant,
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 22),
        TextField(
          onChanged: controller.searchPlayers,
          style: TextStyle(color: colors.onSurface),
          decoration: InputDecoration(
            hintText: 'football_search'.tr,
            prefixIcon: const Icon(Icons.search_rounded),
            filled: true,
            fillColor: colors.surfaceContainerLow,
            hintStyle: TextStyle(color: colors.onSurfaceVariant),
            prefixIconColor: colors.onSurfaceVariant,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 15,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13),
              borderSide: BorderSide(color: colors.outlineVariant),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13),
              borderSide: BorderSide(color: colors.outlineVariant),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13),
              borderSide: BorderSide(color: colors.primary, width: 1.5),
            ),
          ),
        ),
        const SizedBox(height: 13),
        Obx(
          () => DropdownButtonFormField<String>(
            initialValue: controller.selectedPosition.value,
            dropdownColor: colors.surfaceContainerHighest,
            style: TextStyle(
              color: colors.onSurface,
              fontSize: 14,
            ),
            decoration: InputDecoration(
              labelText: 'football_position'.tr,
              labelStyle: TextStyle(color: colors.onSurfaceVariant),
              prefixIcon: const Icon(Icons.filter_list_rounded),
              filled: true,
              fillColor: colors.surfaceContainerLow,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 12,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(13),
                borderSide: BorderSide(color: colors.outlineVariant),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(13),
                borderSide: BorderSide(color: colors.outlineVariant),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(13),
                borderSide: BorderSide(color: colors.primary, width: 1.5),
              ),
            ),
            items: controller.positions.map((position) {
              return DropdownMenuItem(
                value: position,
                child: Text(
                  _positionLabel(position),
                  style: TextStyle(color: colors.onSurface),
                ),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                controller.filterPosition(value);
              }
            },
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Obx(
              () => Text(
                '${controller.players.length} '
                '${isIndonesian ? 'PEMAIN DITEMUKAN' : 'PLAYERS FOUND'}',
                style: TextStyle(
                  color: colors.onSurfaceVariant,
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1,
                ),
              ),
            ),
            const Spacer(),
            TextButton.icon(
              onPressed: controller.clearFilters,
              icon: const Icon(Icons.restart_alt_rounded, size: 17),
              label: Text(isIndonesian ? 'Atur ulang' : 'Reset filters'),
              style: TextButton.styleFrom(
                foregroundColor: colors.primary,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildEmptySearch(BuildContext context, ColorScheme colors) {
    final isIndonesian = Get.locale?.languageCode == 'id';

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 76,
              height: 76,
              decoration: BoxDecoration(
                color: colors.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Icon(
                Icons.search_off_rounded,
                color: colors.onSurfaceVariant,
                size: 34,
              ),
            ),
            const SizedBox(height: 18),
            Text(
              'football_no_players'.tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: colors.onSurface,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 7),
            Text(
              'football_no_players_description'.tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: colors.onSurfaceVariant,
                fontSize: 13,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 15),
            TextButton(
              onPressed: controller.clearFilters,
              child: Text(isIndonesian ? 'Hapus filter' : 'Clear filters'),
            ),
          ],
        ),
      ),
    );
  }
}

class FootballPlayerCard extends StatelessWidget {
  final FootballModel player;
  final FootballCtr controller;

  const FootballPlayerCard({
    super.key,
    required this.player,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Material(
      color: colors.surfaceContainerLow,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Get.toNamed(Routes.footballDetail, arguments: player);
        },
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: colors.outlineVariant),
          ),
          child: Row(
            children: [
              Container(
                width: 55,
                height: 55,
                decoration: BoxDecoration(
                  color: colors.secondaryContainer,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Text(
                    player.name.isNotEmpty
                        ? player.name[0].toUpperCase()
                        : '?',
                    style: TextStyle(
                      color: colors.onSecondaryContainer,
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      player.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: colors.onSurface,
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      player.team,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: colors.onSurfaceVariant,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            player.position.toUpperCase(),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: colors.primary,
                              fontSize: 9,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.6,
                            ),
                          ),
                        ),
                        Text(
                          '  /  ',
                          style: TextStyle(
                            color: colors.onSurfaceVariant,
                            fontSize: 10,
                          ),
                        ),
                        Flexible(
                          child: Text(
                            player.country,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: colors.onSurfaceVariant,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Obx(
                () {
                  final isFavorite = controller.isFavorite(player.name);

                  return IconButton(
                    tooltip: isFavorite
                        ? 'football_remove_favorite'.tr
                        : 'football_add_favorite'.tr,
                    visualDensity: VisualDensity.compact,
                    onPressed: () {
                      controller.toggleFavorite(player.name);
                    },
                    icon: Icon(
                      isFavorite
                          ? Icons.favorite_rounded
                          : Icons.favorite_border_rounded,
                      color: isFavorite
                          ? colors.error
                          : colors.onSurfaceVariant,
                      size: 21,
                    ),
                  );
                },
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: colors.onSurfaceVariant,
                size: 19,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
