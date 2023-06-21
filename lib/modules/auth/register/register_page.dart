import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:who_am_i/modules/auth/login/login_page.dart';
import 'package:who_am_i/modules/auth/register/controller/register_controller.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});
  RegisterController c = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.only(left: 25, right: 25),
        child: ListView(
          children: [
            SizedBox(
              height: 50,
            ),
            Center(
                child: Obx(
              () => c.pickedImage.value == null
                  ? Container(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.width * 0.01),
                      decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.all(Radius.circular(
                              MediaQuery.of(context).size.width * 0.2))),
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                        size: MediaQuery.of(context).size.width * 0.2,
                      ),
                    )
                  : ClipOval(
                      child: Image.file(
                      File(c.pickedImage.value!.path),
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width * 0.21,
                      height: MediaQuery.of(context).size.width * 0.21,
                    )),
            )),
            SizedBox(
              height: 15,
            ),
            Obx(
              () => Text(
                c.nameInputShow.value == ''
                    ? 'Who am I?'
                    : c.nameInputShow.value,
                style: TextStyle(
                    color: Colors.purple[800],
                    fontWeight: FontWeight.w600,
                    fontSize: 30),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Name',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
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
                          borderSide:
                              BorderSide(width: 0, style: BorderStyle.none),
                          borderRadius: BorderRadius.circular(5))),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Username',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: c.usernameInput,
                  maxLength: 50,
                  decoration: InputDecoration(
                      hintText: 'Enter your username here',
                      filled: true,
                      fillColor: Color.fromARGB(255, 243, 243, 243),
                      contentPadding: EdgeInsets.all(12),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 0, style: BorderStyle.none),
                          borderRadius: BorderRadius.circular(5))),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Password',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
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
                          borderSide:
                              BorderSide(width: 0, style: BorderStyle.none),
                          borderRadius: BorderRadius.circular(5))),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Date of Birth',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
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
                          borderSide:
                              BorderSide(width: 0, style: BorderStyle.none),
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
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
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
                                borderRadius: BorderRadius.circular(5),
                                color: c.genderOption.value == 'Male'
                                    ? Colors.lightBlue
                                    : Color.fromARGB(255, 243, 243, 243),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.male,
                                    color: c.genderOption.value == 'Male'
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
                                        color: c.genderOption.value == 'Male'
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
                              padding: EdgeInsets.symmetric(vertical: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: c.genderOption.value == 'Female'
                                    ? Colors.pink
                                    : Color.fromARGB(255, 243, 243, 243),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.female,
                                    color: c.genderOption.value == 'Female'
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
                                        color: c.genderOption.value == 'Female'
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
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 10),
                        LoadingAnimationWidget.waveDots(
                          color: const Color.fromARGB(255, 106, 27, 154),
                          size: MediaQuery.of(context).size.width * 0.08,
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
                                  backgroundColor:
                                      Color.fromARGB(255, 86, 0, 101)),
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
                                  fontSize: 20, fontWeight: FontWeight.w600),
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
                                      backgroundColor:
                                          Color.fromARGB(255, 86, 0, 101)),
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
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: 10),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Longitude: '),
                                Text(c.longitudePoint.toString()),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Latitude: '),
                                Text(c.latitudePoint.toString()),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Address: '),
                                Flexible(child: Text(c.address.toString())),
                              ],
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
                                      backgroundColor:
                                          Color.fromARGB(255, 86, 0, 101)),
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
                        size: MediaQuery.of(context).size.width * 0.2,
                      ),
                      Obx(
                        () => Text(
                          c.pickedImage.value == null
                              ? 'Select your image'
                              : 'Image selected',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20),
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
                c.sendData(context);
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
              selectedBackgroundColor: Color.fromARGB(255, 243, 243, 243),
              backgroundColor: Color.fromARGB(255, 86, 0, 101),
              borderWidth: 1,
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already have an account? '),
                  Flexible(
                      child: GestureDetector(
                    child: Text(
                      'Login',
                      style: TextStyle(color: Colors.purple[800]),
                    ),
                    onTap: () {
                      Get.back();
                    },
                  ))
                ],
              ),
            ),
            SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}
