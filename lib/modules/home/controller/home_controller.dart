import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:who_am_i/globals/api_url.dart';

class HomeController extends GetxController {
  final Dio _dio = Dio();
  final box = GetStorage();

  RxList<dynamic> usersData = RxList<dynamic>();
  RxList<dynamic> statusData = RxList<dynamic>();
  RxList myData = RxList();

  @override
  void onInit() {
    super.onInit();
    getUsersData();
    getStatusData();
    getMyData();
  }

  @override
  void dispose() {
    // Cancel any ongoing requests or cleanup operations
    _dio.close();
    super.dispose();
  }

  void loadData() {
    getMyData();
    getUsersData();
  }

  Future<void> getUsersData() async {
    try {
      final response = await _dio.get(ApiURL.currentApiURL + '/users');
      if (response.statusCode == 200) {
        usersData.value = response.data;
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

  Future<void> getMyData() async {
    var userId = box.read('userId');
    try {
      final response = await _dio
          .get(ApiURL.currentApiURL + '/users?id=' + userId.toString());
      if (response.statusCode == 200) {
        myData.value = response.data;
        print('ini mudata');
        print(myData.value);
      }
    } catch (e) {
      box.remove('userId');
      Get.offAllNamed('/auth/login');
    }
  }
}
