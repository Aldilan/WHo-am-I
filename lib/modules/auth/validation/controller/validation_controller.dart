import 'dart:io';
import 'package:cool_alert/cool_alert.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:who_am_i/globals/api_url.dart';
import 'package:device_info/device_info.dart';

class ValidationController extends GetxController {
  final BuildContext context;
  ValidationController({required this.context});
  final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
  final Dio _dio = Dio();
  GetStorage box = GetStorage();

  Position? currentPosition;
  RxString userId = RxString('');
  RxList<dynamic> latlongData = RxList<dynamic>();
  RxBool isInLocation = RxBool(false);

  @override
  void onInit() {
    super.onInit();
    init();
  }

  Future<void> init() async {
    await getLatLong();
    // getDeviceId();
    // getMyData();
  }

// Fix here
  Future<void> getLatLong() async {
    try {
      final response =
          await _dio.get(ApiURL.currentApiURL + '/validation/location');
      if (response.statusCode == 200 && response.data.toString() != '[]') {
        latlongData.value = response.data;
        determinePosition();
      }
    } catch (e) {
      print('cannot get location');
    }
  }

  Future<void> determinePosition() async {
    print(currentPosition);
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      ).catchError((error) {
        print('Error getting current position: $error');
      });
      print(currentPosition);

      if (currentPosition != null) {
        double latitudeNow = currentPosition!.latitude;
        double longitudeNow = currentPosition!.longitude;
        checkLocation(latitudeNow, longitudeNow);
      }
      update();
    }
  }

  void checkLocation(double currentLatitude, double currentLongitude) {
    for (var i = 0; i < latlongData.length; i++) {
      final String lat = latlongData[i]['latitude'].toString();
      final String lng = latlongData[i]['longitude'].toString();
      final String radius = latlongData[i]['radius'].toString();
      print(lng);

      if (lat.isNotEmpty && lng.isNotEmpty) {
        try {
          final double latitude = double.parse(lat);
          final double longitude = double.parse(lng);
          final double targetRadius = double.parse(radius);

          final double distance = Geolocator.distanceBetween(
            currentLatitude,
            currentLongitude,
            latitude,
            longitude,
          );

          if (distance <= targetRadius) {
            isInLocation.value = true;
          }
          print(isInLocation);
        } catch (e) {
          print('Invalid latitude or longitude value');
        }
      } else {
        print('Latitude or longitude value is null or empty');
      }
    }
    if (isInLocation.value) {
      isInLocation.value = false;
      getDeviceId();
    } else {
      CoolAlert.show(
          backgroundColor: Colors.deepPurple,
          confirmBtnColor: Colors.deepPurple,
          text: 'You are not in location',
          context: context,
          type: CoolAlertType.error,
          barrierDismissible: false,
          onConfirmBtnTap: () {
            getLatLong();
          });
    }
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
      getMyData();
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
