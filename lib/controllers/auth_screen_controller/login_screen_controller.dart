import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_99/global/router/app_pages.dart';
import 'package:fitness_99/helpers/auth.helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  DocumentSnapshot? documentSnapshot;
  final emailTED = TextEditingController();
  final passwordTED = TextEditingController();
  final form = GlobalKey<FormState>();
  final emailErr = ''.obs;
  final passwordErr = ''.obs;
  final apiCalling = false.obs;

  bool validateEmail() {
    if (emailTED.value.text.isEmpty) {
      emailErr.value = 'Enter email address';
      return false;
    } else if (!emailTED.value.text.isEmail) {
      emailErr.value = 'Enter valid email address';
      return false;
    } else {
      return true;
    }
  }

  bool validatePassword() {
    if (passwordTED.value.text.isEmpty) {
      passwordErr.value = 'Enter password';
      return false;
    } else {
      return true;
    }
  }

  // void addData() async {
  //   try {
  //     await firebaseFirestore.collection('users').doc('2').set(
  //       {
  //         'first_name': 'Saiprasad',
  //       },
  //     );
  //     print('added successfully data');
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  // Future<void> retriveData() async {
  //   try {
  //     documentSnapshot =
  //         await firebaseFirestore.collection('users').doc('1').get();
  //     print('The date is ${documentSnapshot!.data()}');
  //   } catch (e) {
  //     print('retrieve Data error ${e.toString()}');
  //   }
  // }

  void login() {
    validateEmail();
    validatePassword();
    if (validateEmail() && validateEmail()) {
      apiCalling.value = true;

      AuthenticationHelper()
          .signIn(email: emailTED.value.text, password: passwordTED.value.text)
          .then((result) async {
        if (result == null) {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          preferences.setString('email', emailTED.value.text);
          print('THe shard pref is ${preferences.getString('email')}');
          Get.back();
          Get.offNamed(Routes.ChatScreen);
        } else {
          apiCalling.value = false;
          Get.snackbar(
            'Invalid Credentials',
            'The entered values are invalid',
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      });
    }
  }
  // }
}
