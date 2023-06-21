import 'package:cool_alert/cool_alert.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:who_am_i/globals/api_url.dart';

class StatusFormController extends GetxController {
  final picker = ImagePicker();
  final box = GetStorage();
  final dio.Dio _dio = dio.Dio();

  RxList myData = RxList();
  TextEditingController titleInput = TextEditingController();
  TextEditingController contentInput = TextEditingController();

  @override
  void onInit() {
    getMyData();
    super.onInit();

    @override
    void dispose() {
      _dio.close();
      super.dispose();
    }
  }

  Future<void> getMyData() async {
    var userId = box.read('userId');
    try {
      final response = await _dio
          .get(ApiURL.currentApiURL + '/users?id=' + userId.toString());
      if (response.statusCode == 200) {
        myData.value = response.data;
        print(myData.value);
      }
    } catch (e) {
      box.remove('userId');
      Get.offAllNamed('/auth/login');
    }
  }

  Future<void> sendData(context) async {
    if (titleInput.text == '' || contentInput.text == '') {
      print('null');
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
          ApiURL.currentApiURL + '/status',
          data: {
            "title": titleInput.text,
            "content": contentInput.text,
            "user_id": myData[0]['id']
          },
        );

        // Handle the response
        if (response.statusCode == 200) {
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
