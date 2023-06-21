import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:get/get.dart';
import 'package:who_am_i/modules/auth/login/controller/login_controller.dart';
import 'package:who_am_i/modules/auth/register/register_page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  LoginController c = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: ListView(
          children: [
            SizedBox(
              height: 50,
            ),
            Center(
              child: ClipOval(
                child: Image.network(
                  'https://cdn.dribbble.com/users/1061278/screenshots/9358911/media/960a80e6c908cbcbef142ded90c9596b.png?resize=400x0',
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
                    'Welcome Back!',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                  ),
                  Text("We're so excited to see you again!")
                ],
              ),
            ),
            SizedBox(
              height: 50,
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
            SizedBox(
              height: 10,
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
                  controller: c.passwordInput,
                  obscureText: true,
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
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Need an account? '),
                  Flexible(
                      child: GestureDetector(
                    child: Text(
                      'Register',
                      style: TextStyle(color: Colors.purple[800]),
                    ),
                    onTap: () {
                      Get.toNamed('/auth/register');
                    },
                  ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
