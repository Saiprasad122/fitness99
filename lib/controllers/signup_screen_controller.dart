import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreenController extends GetxController {
  final emailTED = TextEditingController();
  final passwordTED = TextEditingController();
  final nameTED = TextEditingController();
  final form = GlobalKey<FormState>();
  bool apiCalling = false;

  void signup() {
    // if (_form.currentState?.validate() ?? false) {
    //   setState(() {
    //     _apiCalling = true;
    //   });
    //   AuthenticationHelper()
    //       .signUp(email: emailTED.text, password: passwordTED.text)
    //       .then((result) {
    //     if (result == null) {
    //       Navigator.pop(context);
    //       Navigator.pushReplacementNamed(context, ProfileScreen.id);
    //     } else {
    //       setState(() {
    //         _apiCalling = false;
    //       });
    //       ScaffoldMessenger.of(context).clearSnackBars();
    //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //         content: Text(
    //           result,
    //           style: TextStyle(fontSize: 16),
    //         ),
    //       ));
    //     }
    //   });
    // }
  }
}
