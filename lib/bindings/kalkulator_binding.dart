import 'package:get/get.dart';

import '../controllers/kalkulator_controller.dart';

class KalkulatorBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<KalkulatorController>()) {
      Get.put(KalkulatorController(), permanent: true);
    }
  }
}
