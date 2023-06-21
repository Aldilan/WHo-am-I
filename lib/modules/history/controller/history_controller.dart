import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:who_am_i/globals/api_url.dart';

class HistoryController extends GetxController {
  final Dio _dio = Dio();
  final box = GetStorage();

  RxList<dynamic> statusData = RxList<dynamic>();

  @override
  void onInit() {
    super.onInit();
    getStatusData();
  }

  @override
  void dispose() {
    // Cancel any ongoing requests or cleanup operations
    _dio.close();
    super.dispose();
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
