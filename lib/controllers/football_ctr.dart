import 'package:get/get.dart';
import 'package:latihan_flutter/models/football_model.dart';

class FootballCtr extends GetxController {
  final players = <FootballModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadFootballPlayers();
  }

  void loadFootballPlayers() {
    players.add(
      FootballModel(name: "Messi", position: "striker", team: "Barcelona"),
    );
    players.add(
      FootballModel(
        name: "C. Ronaldo",
        position: "striker",
        team: "Real Madrid",
      ),
    );
  }
}
