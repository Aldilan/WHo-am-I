import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:who_am_i/index.dart';
import 'package:who_am_i/modules/auth/login/login_page.dart';
import 'package:who_am_i/modules/auth/register/register_page.dart';
import 'package:who_am_i/modules/auth/validation/controller/validation_controller.dart';
import 'package:who_am_i/modules/auth/validation/validation_page.dart';
import 'package:who_am_i/modules/home/home_page.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/validation',
      initialBinding: BindingsBuilder(() {
        Get.lazyPut(() => ValidationController());
      }),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.purple),
      getPages: [
        GetPage(name: '/', page: () => IndexPage()),
        GetPage(name: '/auth/login', page: () => LoginPage()),
        GetPage(name: '/auth/register', page: () => RegisterPage()),
        GetPage(name: '/validation', page: () => ValidationPage()),
      ],
    );
  }
}
