import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:who_am_i/globals/api_url.dart';

class HomeController extends GetxController {
  final Dio _dio = Dio();

  RxString userId = RxString('');
  RxList<dynamic> usersData = RxList<dynamic>();
  RxList myData = RxList();

  @override
  void onInit() {
    super.onInit();
    setUserId();
    getUsersData();
  }

  @override
  void dispose() {
    // Cancel any ongoing requests or cleanup operations
    _dio.close();
    super.dispose();
  }

  Future<void> setUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userIdPrefs = prefs.getString('userId');
    if (userIdPrefs.toString() != 'null') {
      userId.value = userIdPrefs.toString();
      getMyData();
    }
    print(userId.value);
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

  Future<void> getMyData() async {
    print(myData.value);
    if (userId.value == '') {
      print(userId.value);
    } else {
      try {
        final response = await _dio
            .get(ApiURL.currentApiURL + '/users?id=' + userId.toString());
        if (response.statusCode == 200) {
          myData.value = response.data;
          print(myData.value);
        } else {
          print('Request failed with status code: ${response.statusCode}');
        }
      } catch (e) {
        print('Error: $e');
      }
    }
  }
}
