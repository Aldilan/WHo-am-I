import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:who_am_i/globals/api_url.dart';

class HistoryController extends GetxController {
  final Dio _dio = Dio();
  final box = GetStorage();

  final List<DropdownMenuItem<String>> dropdownItems = [
    DropdownMenuItem(
        value: 'home',
        child: Text(
          'Home',
          style: TextStyle(color: Colors.black),
        )),
    DropdownMenuItem(
        value: 'logout',
        child: Text(
          'Logout',
          style: TextStyle(color: Colors.black),
        )),
  ];

  RxList<dynamic> usersData = RxList<dynamic>();
  RxList<dynamic> statusData = RxList<dynamic>();

  @override
  void onInit() {
    super.onInit();
    getUsersData();
    getStatusData();
  }

  @override
  void dispose() {
    // Cancel any ongoing requests or cleanup operations
    _dio.close();
    super.dispose();
  }

  void dropdownRespond(value, context) {
    if (value == 'home') {
      Get.offAllNamed('/');
    } else {
      CoolAlert.show(
        onConfirmBtnTap: () {
          box.remove('userId');
          Get.offAllNamed('/auth/login');
        },
        autoCloseDuration: Duration(seconds: 10),
        cancelBtnTextStyle:
            TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        backgroundColor: Colors.grey,
        confirmBtnColor: Colors.black,
        context: context,
        type: CoolAlertType.confirm,
        text: "Are you sure want log out?",
      );
    }
  }

  Future<void> getUsersData() async {
    try {
      final response = await _dio.get(ApiURL.currentApiURL + '/users');
      if (response.statusCode == 200) {
        usersData.value = response.data;
        print(response.data);
      } else {
        print('Request failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> getStatusData() async {
    try {
      final response = await _dio.get(ApiURL.currentApiURL + '/status');
      if (response.statusCode == 200) {
        statusData.value = response.data;
      } else {
        print('Request failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
