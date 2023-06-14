import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:who_am_i/modules/form/controller/form_controller.dart';

class FormPage extends StatelessWidget {
  FormPage({super.key});
  FormController c = Get.put(FormController());

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
        padding: EdgeInsets.only(left: 25, right: 25),
        child: ListView(
          children: [
            Center(
                child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.all(Radius.circular(
                            MediaQuery.of(context).size.width * 0.2))),
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: MediaQuery.of(context).size.width * 0.2,
                    ))),
            SizedBox(
              height: 15,
            ),
            Text(
              'Who am I?',
              style: TextStyle(
                  color: Colors.purple[800],
                  fontWeight: FontWeight.w600,
                  fontSize: 30),
              textAlign: TextAlign.center,
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
                children: [
                  Text(
                    'Address',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
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
                  AnimatedButton(
                    onPress: () {
                      c.getLocation();
                    },
                    height: 50,
                    borderRadius: 5,
                    width: MediaQuery.of(context).size.width,
                    text: 'Get your location',
                    textStyle: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                    selectedTextColor: Colors.black,
                    transitionType: TransitionType.TOP_CENTER_ROUNDER,
                    selectedBackgroundColor: Color.fromARGB(255, 243, 243, 243),
                    backgroundColor: Color.fromARGB(255, 86, 0, 101),
                    borderWidth: 1,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            GestureDetector(
              onTap: () {
                c.pickImage();
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
              text: 'SUBMIT',
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
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
