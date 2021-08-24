// import 'package:fitness_99_project/helpers/auth.helper.dart';
import 'package:fitness_99/controllers/signup_screen_controller.dart';
import 'package:fitness_99/global/utils/dimensions.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:fitness_99/global/widgets/custom_detail_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreenView extends StatelessWidget {
  final controller = Get.put(SignUpScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Image.asset(
            'assets/images/onboard_img/fitness_signup_bg.png',
            fit: BoxFit.fill,
            filterQuality: FilterQuality.high,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: Center(
              child: Form(
                key: controller.form,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height:
                          50 * AppSizedBoxConfigs.responsiveHeightValueToDivide,
                    ),
                    Text('Hello,', style: TextStyles.sgproRegular.f24.white),
                    SizedBox(
                      height:
                          20 * AppSizedBoxConfigs.responsiveHeightValueToDivide,
                    ),
                    Text(
                      'SIGN UP',
                      style: TextStyles.sgproBold.f42.white,
                    ),
                    const Spacer(),
                    CustomDetailsTextField(
                      displayText: 'User Name',
                      iconData: Icons.person,
                      hintText: 'john',
                      textInputType: TextInputType.name,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomDetailsTextField(
                      displayText: 'Email Adress',
                      iconData: Icons.email,
                      hintText: 'john@gmail.com',
                      textInputType: TextInputType.emailAddress,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomDetailsTextField(
                      displayText: 'Password',
                      iconData: Icons.vpn_key_sharp,
                      hintText: '*******',
                      isObscureText: true,
                    ),
                    SizedBox(
                      height:
                          40 * AppSizedBoxConfigs.responsiveHeightValueToDivide,
                    ),
                    InkWell(
                      onTap: signup,
                      child: Container(
                        height: 45 *
                            AppSizedBoxConfigs.responsiveHeightValueToDivide,
                        width: double.infinity,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.yellow[700],
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text('SUBMIT',
                            style: TextStyles.sgproMedium.f20.white),
                      ),
                    ),
                    const Spacer()
                  ],
                ),
              ),
            ),
          ),
          if (controller.apiCalling)
            Positioned.fill(
                child: SizedBox.expand(
              child: Container(
                color: Colors.black45,
                child: Center(
                  child: SizedBox(
                      height: 50,
                      width: 50,
                      child: CircularProgressIndicator()),
                ),
              ),
            ))
        ],
      ),
    );
  }

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
