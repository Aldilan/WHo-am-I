import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:who_am_i/globals/api_url.dart';
import 'package:who_am_i/modules/user/detail/detail_page.dart';

class ProfileCard extends StatelessWidget {
  final dynamic myData;
  const ProfileCard({super.key, required this.myData});

  @override
  Widget build(BuildContext context) {
    final birthDate = DateTime.parse(myData[0]['birth']);
    final formattedBirthDate = DateFormat('d MMMM, yyyy').format(birthDate);
    return GestureDetector(
      onTap: () => Get.to(DetailPage(
        userData: myData[0],
        editCond: true,
      )),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 171, 71, 188),
              Color.fromARGB(255, 123, 31, 162),
              Colors.deepPurple,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      myData[0]['name'],
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(formattedBirthDate,
                        style: TextStyle(color: Colors.white, fontSize: 15)),
                    Text(myData[0]['gender'],
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w500)),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      myData[0]['address'],
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    )
                  ],
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(
                    50), // Set the border radius as desired
                child: Image.network(
                  ApiURL.currentImageURL + myData[0]['image'],
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
