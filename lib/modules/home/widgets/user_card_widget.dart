import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:who_am_i/modules/user/detail/detail_page.dart';

class UserCard extends StatelessWidget {
  final dynamic userData;

  UserCard({Key? key, required this.userData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(DetailPage(userData: userData));
      },
      child: Container(
        width: 250,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          shadowColor: Colors.black,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userData['name'], // Access the user's name from the userData
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 15),
                Text(userData['birth'],
                    style: TextStyle(color: Colors.black, fontSize: 15)),
                Text(userData['gender'],
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
