import 'dart:io';

import 'package:cool_alert/cool_alert.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:get_storage/get_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart' hide FormData;
import 'package:intl/intl.dart';
import 'package:who_am_i/globals/api_url.dart';

class DetailController extends GetxController {
  final dynamic userData;
  DetailController({required this.userData});

  final picker = ImagePicker();
  final pickedImage = Rx<XFile?>(null);
  final dio.Dio _dio = dio.Dio();
  final box = GetStorage();

  TextEditingController nameInput = TextEditingController();
  TextEditingController usernameInput = TextEditingController();
  TextEditingController passwordInput = TextEditingController();
  RxString nameInputShow = RxString('');
  TextEditingController birthInput = TextEditingController();
  RxString genderOption = RxString('');
  RxString latitudePoint = RxString('');
  RxString longitudePoint = RxString('');
  RxString address = RxString('');
  RxBool locButtonClicked = RxBool(false);
  RxBool isEdit = RxBool(false);

  @override
  void onInit() {
    print(userData);
    super.onInit();
    nameInput.text = userData['name'];
    usernameInput.text = userData['username'];
    parseBirthDate();
    genderOption.value = userData['gender'];
    address.value = userData['address'];

    nameInput.addListener(() {
      nameInputShow.value = nameInput.text;
    });
  }

  void clickEdit() {
    isEdit.value = !isEdit.value;
  }

  void parseBirthDate() {
    String birthString = userData['birth'];
    DateTime birthDate = DateTime.parse(birthString);
    String formattedBirthDate = DateFormat('yyyy-MM-dd').format(birthDate);

    birthInput.text = formattedBirthDate;
  }

  void lowercaseUsername(value) {
    usernameInput.text = value.toLowerCase();
    usernameInput.selection = TextSelection.fromPosition(
        TextPosition(offset: usernameInput.text.length));
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

  Future<void> getLocation(context) async {
    locButtonClicked.value = true;
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
      locButtonClicked.value = false;
    } catch (e) {
      locButtonClicked.value = false;
    }
  }

  Future<void> pickImage(context) async {
    CoolAlert.show(
      confirmBtnText: 'Camera',
      onConfirmBtnTap: () {
        cameraOption();
      },
      cancelBtnText: 'Gallery',
      onCancelBtnTap: () {
        galleryOption();
      },
      cancelBtnTextStyle:
          TextStyle(color: Colors.purple[800], fontWeight: FontWeight.w600),
      backgroundColor: Colors.deepPurple,
      confirmBtnColor: Colors.deepPurple,
      context: context,
      type: CoolAlertType.confirm,
      text: "Select your image",
    );
  }

  Future<void> cameraOption() async {
    XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      await cropImage(File(image.path));
    }
  }

  Future<void> galleryOption() async {
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      await cropImage(File(image.path));
    }
  }

  Future<void> cropImage(File imageFile) async {
    if (imageFile != null) {
      ImageCropper imageCropper = ImageCropper();
      CroppedFile? croppedFile = await imageCropper.cropImage(
        sourcePath: imageFile.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
      );

      if (croppedFile != null) {
        // Assign the cropped image to the pickedImage variable
        pickedImage.value = XFile(croppedFile.path);
      }
    }
  }

  Future<void> updateData(context) async {
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
        String fileExtension =
            pickedImage.value!.path.split('.').last.toLowerCase();
        String filename = 'image.$fileExtension';
        MediaType contentType =
            MediaType('image', fileExtension == 'png' ? 'png' : 'jpeg');

        final formData = dio.FormData.fromMap({
          'image': await dio.MultipartFile.fromFile(
            pickedImage.value!.path,
            filename: filename,
            contentType: contentType,
          ),
          "username": usernameInput.text,
          "password": passwordInput.text,
          "name": nameInput.text,
          "birth": birthInput.text,
          "gender": genderOption.value,
          "address": address.value,
          "device_id": box.read('device_id'),
        });

        final response = await _dio.put(
          ApiURL.currentApiURL + '/users/' + userData['id'].toString(),
          data: formData,
        );
        if (response.statusCode == 200) {
          Get.offAllNamed('/');
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

  @override
  void dispose() {
    nameInput.dispose();
    birthInput.dispose();
    _dio.close();
    super.dispose();
  }
}
