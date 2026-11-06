import 'package:get/get.dart';

import '../controllers/football_ctr.dart';

class FootballBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<FootballCtr>()) {
      Get.put(FootballCtr(), permanent: true);
    }
  }
}
