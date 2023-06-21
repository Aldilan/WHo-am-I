import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:who_am_i/globals/api_url.dart';
import 'package:who_am_i/modules/user/status/controller/status_form_controller.dart';

class StatusFormPage extends StatelessWidget {
  StatusFormPage({super.key});
  StatusFormController c = Get.put(StatusFormController());

  @override
  Widget build(BuildContext context) {
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
              weight: 100,
              size: 30,
              Icons.arrow_back_ios_new_rounded,
              color: Colors.purple[800],
            )),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: ListView(
          children: [
            CircleAvatar(
              radius: 60,
              backgroundColor: Color.fromARGB(255, 86, 0, 101),
              child: Icon(
                Icons.add_to_photos, // Specify the icon
                size: 60, // Set the size of the icon
                color: Colors.white, // Set the color of the icon
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Center(
              child: Text(
                'Create Status',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Title',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: c.titleInput,
                  decoration: InputDecoration(
                      hintText: 'Enter status title here',
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
            SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Status',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: c.contentInput,
                  decoration: InputDecoration(
                      hintText: 'Enter your status here',
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
            SizedBox(
              height: 10,
            ),
            AnimatedButton(
              onPress: () {
                c.sendData(context);
              },
              height: 50,
              borderRadius: 5,
              width: MediaQuery.of(context).size.width,
              text: 'LOGIN',
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
          ],
        ),
      ),
    );
  }
}
