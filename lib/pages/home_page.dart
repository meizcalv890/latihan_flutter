import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latihan_flutter/routes/routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Get.offAllNamed(Routes.login);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.calculate),
                label: const Text('Kalkulator'),
                onPressed: () {
                  Get.toNamed(Routes.kalkulator);
                },
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.sports_soccer),
                label: const Text('Football'),
                onPressed: () {
                  Get.toNamed(Routes.football);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
