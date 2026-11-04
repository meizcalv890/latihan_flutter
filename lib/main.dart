import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latihan_flutter/routes/pages.dart';
import 'package:latihan_flutter/routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "ini title",
      initialRoute: Routes.login,
      getPages: Pages.pages,
    );
  }
}
