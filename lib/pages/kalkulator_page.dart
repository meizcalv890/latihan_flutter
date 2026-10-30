import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latihan_flutter/components/mybutton.dart';
import 'package:latihan_flutter/components/mytextfield.dart';
import 'package:latihan_flutter/controllers/kalkulator_controller.dart';
import 'package:latihan_flutter/routes/routes.dart';

class KalkulatorPage extends GetView<KalkulatorController> {
  const KalkulatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kalkulator')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            MyTextField(
              label: "Angka A",
              hint: "Masukkan angka A",
              textEditingController: controller.txtA,
              isPassword: false,
              icon: Icons.numbers,
              fontSize: 16,
            ),
            MyTextField(
              label: "Angka B",
              hint: "Masukkan angka B",
              textEditingController: controller.txtB,
              isPassword: false,
              icon: Icons.numbers,
              fontSize: 16,
            ),
            Wrap(
              spacing: 8,
              children: [
                for (final op in ['+', '-', '*', '/'])
                  MyButton(
                    text: op,
                    buttonColor: Colors.blue,
                    borderRadius: 10,
                    fontSize: 18,
                    onPressed: () => controller.hitung(op),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Obx(
              () => Text(
                "Hasil: ${controller.hasil.value}",
                style: const TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 16),
            MyButton(
              text: "Lihat Pemain",
              buttonColor: Colors.green,
              borderRadius: 10,
              fontSize: 16,
              onPressed: () => Get.toNamed(Routes.football),
            ),
          ],
        ),
      ),
    );
  }
}
