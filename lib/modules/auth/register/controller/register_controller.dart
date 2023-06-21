import 'package:cool_alert/cool_alert.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart' hide FormData;
import 'package:intl/intl.dart';
import 'package:who_am_i/globals/api_url.dart';

class RegisterController extends GetxController {
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

  @override
  void onInit() {
    super.onInit();
    birthInput.text = '';

    nameInput.addListener(() {
      nameInputShow.value = nameInput.text;
    });
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
    pickedImage.value = image;
  }

  Future<void> galleryOption() async {
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    pickedImage.value = image;
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
          'name': nameInput.text,
          'username': usernameInput.text,
          'password': passwordInput.text,
          'birth': birthInput.text,
          'gender': genderOption.value,
          'address': address.value,
        });

        print('l');
        final response = await _dio.post(
          ApiURL.currentApiURL + '/users',
          data: formData,
        );
        if (response.statusCode == 200) {
          box.write('userId', response.data['id'].toString());
          print(box.read('userId').toString());
          Get.offAllNamed('/validation');
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
