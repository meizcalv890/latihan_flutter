import 'package:get/get.dart';
import 'package:latihan_flutter/controllers/kalkulator_controller.dart';

class KalkulatorBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(KalkulatorController());
  }
}
