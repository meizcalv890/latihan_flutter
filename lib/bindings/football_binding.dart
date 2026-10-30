import 'package:get/get.dart';
import 'package:latihan_flutter/controllers/football_ctr.dart';

class FootballBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(FootballCtr());
  }
}
