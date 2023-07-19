import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:who_am_i/modules/auth/validation/controller/validation_controller.dart';

class ValidationPage extends StatelessWidget {
  ValidationPage({super.key});

  @override
  Widget build(BuildContext context) {
    ValidationController c = Get.put(ValidationController(context: context));
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: LoadingAnimationWidget.threeArchedCircle(
              color: const Color.fromARGB(255, 106, 27, 154),
              size: MediaQuery.of(context).size.width * 0.2,
            ),
          ),
        ),
      ),
    );
  }
}
