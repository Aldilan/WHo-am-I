import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:who_am_i/globals/api_url.dart';
import 'package:intl/intl.dart';

class DetailPage extends StatelessWidget {
  final dynamic userData;
  const DetailPage({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    final birthDate = DateTime.parse(userData['birth']);
    final formattedBirthDate = DateFormat('d MMMM, yyyy').format(birthDate);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.purple[800],
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: ListView(
          children: [
            Center(
              child: ClipOval(
                child: Image.network(
                  ApiURL.currentImageURL + userData['image'],
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width * 0.25,
                  height: MediaQuery.of(context).size.width * 0.25,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Center(
              child: Text(
                userData['name'],
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              children: [
                Expanded(
                    child: Column(
                  children: [
                    Text(
                      formattedBirthDate,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text('Date of birth'),
                  ],
                )),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: Column(
                  children: [
                    Text(
                      userData['gender'],
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                    Text('Gender'),
                  ],
                )),
              ],
            ),
            SizedBox(
              height: 60,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Address',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10),
                Text(userData['address']),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
