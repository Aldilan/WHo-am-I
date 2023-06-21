import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:who_am_i/globals/api_url.dart';
import 'package:intl/intl.dart';
import 'package:who_am_i/modules/user/detail/controller/detail_controller.dart';

class DetailPage extends StatelessWidget {
  final dynamic userData;
  final bool editCond;
  DetailPage({super.key, required this.userData, required this.editCond});

  @override
  Widget build(BuildContext context) {
    DetailController c = Get.put(DetailController(userData: userData));
    final birthDate = DateTime.parse(userData['birth']);
    final formattedBirthDate = DateFormat('d MMMM, yyyy').format(birthDate);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 100,
        centerTitle: true,
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.black),
        ),
        actions: editCond
            ? [
                Obx(
                  () => IconButton(
                      onPressed: () {
                        c.clickEdit();
                      },
                      icon: Icon(
                          c.isEdit.value ? Icons.edit : Icons.edit_outlined,
                          color: Colors.purple[800])),
                )
              ]
            : [],
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
              child: Column(
                children: [
                  Text(
                    userData['name'],
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '@' + userData['username'],
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Obx(
              () => Column(
                children: c.isEdit.value
                    ? [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Name',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: c.nameInput,
                              maxLength: 30,
                              decoration: InputDecoration(
                                  hintText: 'Enter your name here',
                                  filled: true,
                                  fillColor: Color.fromARGB(255, 243, 243, 243),
                                  contentPadding: EdgeInsets.all(12),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 0, style: BorderStyle.none),
                                      borderRadius: BorderRadius.circular(5))),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Password',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              obscureText: true,
                              controller: c.passwordInput,
                              maxLength: 50,
                              decoration: InputDecoration(
                                  hintText: 'Enter your password here',
                                  filled: true,
                                  fillColor: Color.fromARGB(255, 243, 243, 243),
                                  contentPadding: EdgeInsets.all(12),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 0, style: BorderStyle.none),
                                      borderRadius: BorderRadius.circular(5))),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Date of Birth',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextField(
                              readOnly: true,
                              controller: c.birthInput,
                              decoration: InputDecoration(
                                  hintText: 'Enter your birth date here',
                                  suffixIcon: Icon(Icons.date_range_rounded),
                                  filled: true,
                                  fillColor: Color.fromARGB(255, 243, 243, 243),
                                  contentPadding: EdgeInsets.all(12),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 0, style: BorderStyle.none),
                                      borderRadius: BorderRadius.circular(5))),
                              onTap: () {
                                c.selectDate(context);
                              },
                            )
                          ],
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Select Gender',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: 10),
                            Obx(
                              () => Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        c.pickGender('Male');
                                      },
                                      child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color:
                                                c.genderOption.value == 'Male'
                                                    ? Colors.lightBlue
                                                    : Color.fromARGB(
                                                        255, 243, 243, 243),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 15),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.male,
                                                color: c.genderOption.value ==
                                                        'Male'
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                'Male',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w600,
                                                    color:
                                                        c.genderOption.value ==
                                                                'Male'
                                                            ? Colors.white
                                                            : Colors.black),
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          )),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        c.pickGender('Female');
                                      },
                                      child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 15),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color:
                                                c.genderOption.value == 'Female'
                                                    ? Colors.pink
                                                    : Color.fromARGB(
                                                        255, 243, 243, 243),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.female,
                                                color: c.genderOption.value ==
                                                        'Female'
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                'Female',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w600,
                                                    color:
                                                        c.genderOption.value ==
                                                                'Female'
                                                            ? Colors.white
                                                            : Colors.black),
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Obx(
                          () => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: c.locButtonClicked.value
                                ? [
                                    Text(
                                      'Address',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(height: 10),
                                    LoadingAnimationWidget.waveDots(
                                      color: const Color.fromARGB(
                                          255, 106, 27, 154),
                                      size: MediaQuery.of(context).size.width *
                                          0.08,
                                    ),
                                    SizedBox(height: 10),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      height: 50,
                                      child: ElevatedButton(
                                          onPressed: () {
                                            c.getLocation(context);
                                          },
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Color.fromARGB(
                                                  255, 86, 0, 101)),
                                          child: Text(
                                            'Get your location',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          )),
                                    ),
                                  ]
                                : c.address.value == ''
                                    ? [
                                        Text(
                                          'Address',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(height: 10),
                                        SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 50,
                                          child: ElevatedButton(
                                              onPressed: () {
                                                c.getLocation(context);
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Color.fromARGB(
                                                          255, 86, 0, 101)),
                                              child: Text(
                                                'Get your location',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              )),
                                        ),
                                      ]
                                    : [
                                        Text(
                                          'Address',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('Longitude: '),
                                            Text(c.longitudePoint.toString()),
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('Latitude: '),
                                            Text(c.latitudePoint.toString()),
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('Address: '),
                                            Flexible(
                                                child:
                                                    Text(c.address.toString())),
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 50,
                                          child: ElevatedButton(
                                              onPressed: () {
                                                c.getLocation(context);
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Color.fromARGB(
                                                          255, 86, 0, 101)),
                                              child: Text(
                                                'Get your location',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              )),
                                        ),
                                      ],
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        GestureDetector(
                          onTap: () {
                            c.pickImage(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Color.fromARGB(255, 243, 243, 243),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 30),
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.image,
                                    size:
                                        MediaQuery.of(context).size.width * 0.2,
                                  ),
                                  Obx(
                                    () => Text(
                                      c.pickedImage.value == null
                                          ? 'Select your image'
                                          : 'Image selected',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        AnimatedButton(
                          onPress: () {
                            c.updateData(context);
                          },
                          height: 50,
                          borderRadius: 5,
                          width: MediaQuery.of(context).size.width,
                          text: 'CREATE',
                          textStyle: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                          selectedTextColor: Colors.black,
                          transitionType: TransitionType.TOP_CENTER_ROUNDER,
                          selectedBackgroundColor:
                              Color.fromARGB(255, 243, 243, 243),
                          backgroundColor: Color.fromARGB(255, 86, 0, 101),
                          borderWidth: 1,
                        ),
                      ]
                    : [
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
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600),
                                  textAlign: TextAlign.center,
                                ),
                                Text('Gender'),
                              ],
                            )),
                          ],
                        ),
                        SizedBox(
                          height: 50,
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
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
