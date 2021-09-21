import 'dart:io';

import 'package:dio/dio.dart' as Dio;
import 'package:fitness_99/core/api/api_service.dart';
import 'package:fitness_99/core/services/data_model.dart';
import 'package:fitness_99/core/services/user_model_service.dart';
import 'package:fitness_99/global/widgets/custom_snackbar.dart';
import 'package:fitness_99/models/updateProfilePicture/update_profile_picture_request.dart';
import 'package:fitness_99/models/updateProfilePicture/update_profile_picture_response.dart';
import 'package:fitness_99/models/updateProfileResponseRequest/updateProfileResponse.dart';
import 'package:fitness_99/models/updateProfileResponseRequest/update_profile_request.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class EditProfileController extends GetxController {
  final apiService = Get.find<ApiService>();
  final userModel = Get.find<UserModelService>();
  final nameTED = TextEditingController();
  final emailTED = TextEditingController();
  final numberTED = TextEditingController();
  final image = ''.obs;
  final nameErr = ''.obs;
  final emailErr = ''.obs;
  final numberErr = ''.obs;
  final numberTextInputFormatter = LengthLimitingTextInputFormatter(10);
  final picker = ImagePicker();
  final img = File('').obs;
  final apiCalling = false.obs;
  MultipartFile? uploadImage;
  UpdateProfilePictureRequest req = UpdateProfilePictureRequest();
  UpdateProfilePictureResponse? response;

  @override
  void onInit() {
    nameTED.text = userModel.getUserName();
    emailTED.text = userModel.getEmail();
    numberTED.text = userModel.getMobileNumber();
    image.value = userModel.getProfilePicture();
    super.onInit();
  }

  bool validateEmail() {
    if (emailTED.value.text.isEmpty) {
      emailErr.value = 'Enter email address';
      return false;
    } else if (!GetUtils.isEmail(emailTED.value.text)) {
      emailErr.value = 'Enter valid email address';
      return false;
    } else {
      emailErr.value = '';
      return true;
    }
  }

  bool validateName() {
    if (nameTED.value.text.isEmpty) {
      nameErr.value = 'Enter user name';
      return false;
    } else {
      nameErr.value = '';
      return true;
    }
  }

  bool validateNumber() {
    if (numberTED.value.text.isEmpty) {
      numberErr.value = 'Enter mobile number';
      return false;
    } else if (!numberTED.value.text.isPhoneNumber) {
      numberErr.value = 'Enter valid mobile number';
      return false;
    } else if (!numberTED.value.text.startsWith(RegExp(r'[6-9]'))) {
      numberErr.value = 'Enter a valid mobile number';
      return false;
    } else {
      numberErr.value = '';
      return true;
    }
  }

  Future pickImage() async {
    try {
      final file = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
        maxHeight: 500,
        maxWidth: 500,
      );
      img.value = File(file?.path ?? '');
      var fileName = img.value.path.split('/').last;
      uploadImage = MultipartFile(
        img.value.path,
        filename: fileName,
      );
      req = req.copyWith(userId: userModel.getid());
      req = req.copyWith(profilePicture: uploadImage);
      var formData = FormData(req.toJson());

      try {
        final dio = Dio.Dio()
          ..interceptors.add(PrettyDioLogger(requestBody: true));
        final result = await dio.post(
          'http://fitness.rithlaundry.com/api/user/profile_picture',
          data: formData,
        );
        response = UpdateProfilePictureResponse.fromJson(result.data);
        print('The response data is $response');
      } catch (e) {}

      print('The image path is ${img.value}');
    } catch (e) {
      print(e);
    }
  }

  void submit() async {
    validateEmail();
    validateName();
    validateNumber();
    if (validateEmail() && validateName() && validateNumber()) {
      apiCalling.value = true;
      await updateProfileApi(
        id: userModel.getid(),
        email: emailTED.value.text,
        mobileNumber: numberTED.value.text,
        profilePicture: userModel.getProfilePicture(),
        userName: nameTED.value.text,
      );
      Get.back();
      customSnackBar(
        'Success!',
        'Your profile is created successfully',
        'success',
      );
    }
  }

  Future<void> updateProfileApi({
    required int id,
    required String email,
    required String mobileNumber,
    required String profilePicture,
    required String userName,
  }) async {
    UpdateProfileRequest body = UpdateProfileRequest(
      id: id,
      email: email,
      phoneNumber: mobileNumber,
      profilePicture: profilePicture,
      userName: userName,
    );
    final res = await apiService.getUpdateProfileResponse(body);

    if (res.message.toLowerCase() == 'success') {
      DataModel dataModel = DataModel(
        id: res.result.id,
        userName: res.result.userName,
        email: res.result.email,
        mobileNumber: res.result.phoneNumber,
        numbesrOfGroups: "0",
        profilePicture: res.result.profilePicture,
      );
      await Hive.box<DataModel>('user_data').put('data', dataModel);
      apiCalling.value = false;
    }
  }
}
