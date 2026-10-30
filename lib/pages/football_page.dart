import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latihan_flutter/controllers/football_ctr.dart';
import 'package:latihan_flutter/routes/routes.dart';

class FootballPage extends GetView<FootballCtr> {
  const FootballPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (Navigator.of(context).canPop()) {
              Get.back();
            } else {
              Get.offAllNamed(Routes.kalkulator);
            }
          },
        ),
        title: const Text('List Players'),
      ),
      body: Obx(() {
        return ListView.builder(
          itemCount: controller.players.length,
          itemBuilder: (context, index) {
            final player = controller.players[index];
            return Card(
              child: ListTile(
                title: Text(player.name),
                subtitle: Text(player.position),
              ),
            );
          },
        );
      }),
    );
  }
}
