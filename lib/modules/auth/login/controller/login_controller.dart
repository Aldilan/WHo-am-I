import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:who_am_i/globals/api_url.dart';

class LoginController extends GetxController {
  TextEditingController usernameInput = TextEditingController();
  TextEditingController passwordInput = TextEditingController();
  final box = GetStorage();
  final dio.Dio _dio = dio.Dio();

  Future<void> sendData(context) async {
    if (usernameInput.text == '' || passwordInput.text == '') {
      CoolAlert.show(
        backgroundColor: Colors.deepPurple,
        confirmBtnColor: Colors.deepPurple,
        context: context,
        type: CoolAlertType.error,
        text: "Missing some data!",
      );
    } else {
      try {
        final response = await _dio.post(
          ApiURL.currentApiURL + '/users/login',
          data: {
            "username": usernameInput.text,
            "password": passwordInput.text,
          },
        );

        if (response.statusCode == 200) {
          box.write('userId', response.data['id'].toString());
          print(box.read('userId').toString());
          Get.offAllNamed('/validation');
        } else {
          CoolAlert.show(
            backgroundColor: Colors.deepPurple,
            confirmBtnColor: Colors.deepPurple,
            context: context,
            type: CoolAlertType.error,
            text: "Something wrong, try again later!",
          );
        }
      } catch (e) {
        CoolAlert.show(
          backgroundColor: Colors.deepPurple,
          confirmBtnColor: Colors.deepPurple,
          context: context,
          type: CoolAlertType.error,
          text: "Something wrong, try again later!",
        );
      }
    }
  }
}
