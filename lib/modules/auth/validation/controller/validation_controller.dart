import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:who_am_i/globals/api_url.dart';
import 'package:device_info/device_info.dart';

class ValidationController extends GetxController {
  final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
  final Dio _dio = Dio();
  GetStorage box = GetStorage();
  RxString userId = RxString('');

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getDeviceId();
      getMyData();
    });
  }

  Future<void> getDeviceId() async {
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        box.write('device_id', build.androidId);
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        box.write('device_id', data.identifierForVendor);
      }
    } on PlatformException {
      print('Failed');
    }
  }

  Future<void> getMyData() async {
    if (box.read('userId') == null) {
      Get.offAllNamed('/auth/login');
    } else {
      userId.value = box.read('userId').toString();
      try {
        final response =
            await _dio.get(ApiURL.currentApiURL + '/users?id=' + userId.value);
        if (response.statusCode == 200 && response.data.toString() != '[]') {
          Get.offAllNamed('/');
        } else {
          box.remove('userId');
          Get.offAllNamed('/auth/login');
        }
      } catch (e) {
        box.remove('userId');
        Get.offAllNamed('/auth/login');
      }
    }
  }
}
