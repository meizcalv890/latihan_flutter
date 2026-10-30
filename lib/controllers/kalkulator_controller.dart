import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KalkulatorController extends GetxController {
  final txtA = TextEditingController();
  final txtB = TextEditingController();
  final hasil = "0".obs;

  void hitung(String operator) {
    final a = double.tryParse(txtA.text);
    final b = double.tryParse(txtB.text);

    if (a == null || b == null) {
      hasil.value = "Input tidak valid";
      return;
    }

    double r;
    switch (operator) {
      case '+':
        r = a + b;
        break;
      case '-':
        r = a - b;
        break;
      case '*':
        r = a * b;
        break;
      default:
        if (b == 0) {
          hasil.value = "Tidak bisa dibagi 0";
          return;
        }
        r = a / b;
    }
    hasil.value = r.toString();
  }

  @override
  void onClose() {
    txtA.dispose();
    txtB.dispose();
    super.onClose();
  }
}
