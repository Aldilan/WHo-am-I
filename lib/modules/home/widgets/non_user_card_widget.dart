import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:get/get.dart';
import 'package:who_am_i/modules/user/form/form_page.dart';

class NonUserCard extends StatelessWidget {
  const NonUserCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    'User not found',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    child: Text('Create here'),
                    onPressed: () {
                      Get.to(FormPage());
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
