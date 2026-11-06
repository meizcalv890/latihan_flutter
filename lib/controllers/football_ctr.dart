import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../models/football_model.dart';

class FootballCtr extends GetxController {
  final storage = GetStorage();

  final players = <FootballModel>[].obs;
  final customPlayers = <FootballModel>[].obs;
  final favoriteNames = <String>[].obs;

  final searchQuery = ''.obs;
  final selectedPosition = 'All'.obs;

  final List<FootballModel> allPlayers = [
    FootballModel(
      name: 'Lionel Messi',
      position: 'Forward',
      team: 'Inter Miami',
      country: 'Argentina',
      number: 10,
      description:
          'Lionel Messi adalah pemain sepak bola asal Argentina '
          'yang dikenal dengan kemampuan dribbling, kreativitas, '
          'dan kontribusinya dalam mencetak gol.',
    ),
    FootballModel(
      name: 'Cristiano Ronaldo',
      position: 'Forward',
      team: 'Al Nassr',
      country: 'Portugal',
      number: 7,
      description:
          'Cristiano Ronaldo merupakan pemain sepak bola asal '
          'Portugal yang dikenal dengan kemampuan mencetak gol '
          'dan performanya di berbagai kompetisi.',
    ),
    FootballModel(
      name: 'Kylian Mbappe',
      position: 'Forward',
      team: 'Real Madrid',
      country: 'France',
      number: 10,
      description:
          'Kylian Mbappe merupakan pemain asal Prancis yang '
          'dikenal dengan kecepatan dan kemampuan menyerangnya.',
    ),
    FootballModel(
      name: 'Erling Haaland',
      position: 'Forward',
      team: 'Manchester City',
      country: 'Norway',
      number: 9,
      description:
          'Erling Haaland adalah striker asal Norwegia yang '
          'dikenal dengan kemampuan penyelesaian akhirnya.',
    ),
    FootballModel(
      name: 'Jude Bellingham',
      position: 'Midfielder',
      team: 'Real Madrid',
      country: 'England',
      number: 5,
      description:
          'Jude Bellingham merupakan gelandang asal Inggris '
          'yang memiliki kemampuan menyerang dan bertahan.',
    ),
    FootballModel(
      name: 'Kevin De Bruyne',
      position: 'Midfielder',
      team: 'Napoli',
      country: 'Belgium',
      number: 11,
      description:
          'Kevin De Bruyne dikenal sebagai gelandang kreatif '
          'dengan kemampuan umpan dan visi permainan yang baik.',
    ),
    FootballModel(
      name: 'Virgil van Dijk',
      position: 'Defender',
      team: 'Liverpool',
      country: 'Netherlands',
      number: 4,
      description:
          'Virgil van Dijk merupakan bek asal Belanda yang '
          'dikenal dengan kemampuan bertahan dan kepemimpinannya.',
    ),
    FootballModel(
      name: 'Ruben Dias',
      position: 'Defender',
      team: 'Manchester City',
      country: 'Portugal',
      number: 3,
      description:
          'Ruben Dias merupakan bek tengah asal Portugal '
          'yang dikenal dengan kemampuan membaca permainan.',
    ),
    FootballModel(
      name: 'Alisson Becker',
      position: 'Goalkeeper',
      team: 'Liverpool',
      country: 'Brazil',
      number: 1,
      description:
          'Alisson Becker merupakan penjaga gawang asal Brasil '
          'yang dikenal dengan kemampuan penyelamatan dan distribusi bola.',
    ),
    FootballModel(
      name: 'Thibaut Courtois',
      position: 'Goalkeeper',
      team: 'Real Madrid',
      country: 'Belgium',
      number: 1,
      description:
          'Thibaut Courtois merupakan penjaga gawang asal Belgia '
          'yang dikenal dengan refleks dan jangkauannya.',
    ),
  ];

  final List<String> positions = [
    'All',
    'Forward',
    'Midfielder',
    'Defender',
    'Goalkeeper',
  ];

  List<FootballModel> get allAvailablePlayers => [
    ...allPlayers,
    ...customPlayers,
  ];

  @override
  void onInit() {
    super.onInit();
    loadCustomPlayers();
    loadFavorites();
    applyFilters();
  }

  void loadCustomPlayers() {
    final saved = storage.read('custom_players');

    if (saved is List) {
      final loaded = <FootballModel>[];

      for (final item in saved) {
        if (item is Map) {
          loaded.add(FootballModel.fromMap(Map<String, dynamic>.from(item)));
        }
      }

      customPlayers.assignAll(loaded);
    }
  }

  void saveCustomPlayers() {
    storage.write(
      'custom_players',
      customPlayers.map((player) => player.toMap()).toList(),
    );
  }

  void addPlayer(FootballModel player) {
    final newPlayer = FootballModel(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      name: player.name.trim(),
      position: player.position,
      team: player.team.trim(),
      country: player.country.trim(),
      number: player.number,
      description: player.description.trim(),
      isCustom: true,
    );

    customPlayers.add(newPlayer);
    saveCustomPlayers();
    applyFilters();

    Get.snackbar(
      'Success',
      '${newPlayer.name} has been added.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void updatePlayer(FootballModel updatedPlayer) {
    final index = customPlayers.indexWhere(
      (player) => player.id == updatedPlayer.id,
    );

    if (index == -1) return;

    customPlayers[index] = updatedPlayer;
    saveCustomPlayers();
    applyFilters();

    Get.snackbar(
      'Updated',
      '${updatedPlayer.name} has been updated.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void deletePlayer(String? id) {
    if (id == null) return;

    final index = customPlayers.indexWhere((player) => player.id == id);

    if (index == -1) return;

    final deletedName = customPlayers[index].name;

    customPlayers.removeAt(index);
    favoriteNames.remove(deletedName);

    saveCustomPlayers();
    storage.write('favorite_players', favoriteNames.toList());

    applyFilters();

    Get.snackbar(
      'Deleted',
      '$deletedName has been removed.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void searchPlayers(String query) {
    searchQuery.value = query.trim();
    applyFilters();
  }

  void filterPosition(String position) {
    selectedPosition.value = position;
    applyFilters();
  }

  void applyFilters() {
    final query = searchQuery.value.toLowerCase();

    final filtered = allAvailablePlayers.where((player) {
      final matchesSearch =
          query.isEmpty ||
          player.name.toLowerCase().contains(query) ||
          player.team.toLowerCase().contains(query) ||
          player.country.toLowerCase().contains(query) ||
          player.position.toLowerCase().contains(query);

      final matchesPosition =
          selectedPosition.value == 'All' ||
          player.position == selectedPosition.value;

      return matchesSearch && matchesPosition;
    }).toList();

    players.assignAll(filtered);
  }

  void loadFavorites() {
    final saved = storage.read('favorite_players');

    if (saved is List) {
      favoriteNames.assignAll(saved.map((item) => item.toString()).toList());
    }
  }

  bool isFavorite(String name) {
    return favoriteNames.contains(name);
  }

  void toggleFavorite(String name) {
    if (favoriteNames.contains(name)) {
      favoriteNames.remove(name);
    } else {
      favoriteNames.add(name);
    }

    storage.write('favorite_players', favoriteNames.toList());
  }

  List<FootballModel> get favoritePlayers {
    return allAvailablePlayers.where((player) {
      return favoriteNames.contains(player.name);
    }).toList();
  }

  void clearFilters() {
    searchQuery.value = '';
    selectedPosition.value = 'All';
    applyFilters();
  }
}
