import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:who_am_i/index.dart';
import 'package:who_am_i/modules/home/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: IndexPage(),
      theme: ThemeData(primarySwatch: Colors.purple),
    );
  }
}
