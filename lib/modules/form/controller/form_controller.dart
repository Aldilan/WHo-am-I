import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:image_picker/image_picker.dart';
import 'package:who_am_i/globals/api_url.dart';
import 'package:who_am_i/index.dart';
import 'package:who_am_i/modules/home/home_page.dart';

class FormController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  final Dio _dio = Dio();

  TextEditingController nameInput = TextEditingController();
  TextEditingController birthInput = TextEditingController();
  RxString genderOption = RxString('');
  RxString latitudePoint = RxString('');
  RxString longitudePoint = RxString('');
  RxString address = RxString('');
  Rx<ImageProvider?> pickedImage = Rx<ImageProvider?>(null);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    birthInput.text = '';
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      birthInput.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  void pickGender(value) {
    genderOption.value = value;
  }

  Future<void> getLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        latitudePoint.value = position.latitude.toString();
        longitudePoint.value = position.longitude.toString();
        List<Placemark> placemarks = await geocoding.placemarkFromCoordinates(
            position.latitude, position.longitude);

        Placemark placemark = placemarks.first;
        address.value = placemark.street.toString() +
            ', ' +
            placemark.subLocality.toString() +
            ', ' +
            placemark.locality.toString() +
            ', ' +
            placemark.subAdministrativeArea.toString() +
            ', ' +
            placemark.administrativeArea.toString() +
            ', ' +
            placemark.country.toString() +
            ', ' +
            placemark.postalCode.toString();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> pickImage() async {
    print(pickedImage.value.toString());
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      pickedImage.value = FileImage(File(pickedFile.path));
    }
    print(FileImage(File(pickedFile!.path)));
  }

  Future<void> sendData(context) async {
    if (pickedImage.value == null ||
        address.value == '' ||
        genderOption.value == '' ||
        birthInput.text == '' ||
        nameInput.text == '') {
      CoolAlert.show(
        backgroundColor: Colors.deepPurple,
        confirmBtnColor: Colors.deepPurple,
        context: context,
        type: CoolAlertType.error,
        text: "Missing some data!",
      );
    } else {
      try {
        Map<String, dynamic> userData = {
          'name': nameInput.text,
          'birth': birthInput.text,
          'gender': genderOption.value,
          'address': address.value,
          'image': 'sdfds',
        };
        final response = await _dio.post(ApiURL.currentApiURL + '/users',
            data: userData); // Make a GET request
        if (response.statusCode == 200) {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('userId', response.data['id'].toString());
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
