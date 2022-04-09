import 'package:dio/dio.dart' as Dio;
import 'package:fitness_99/controllers/profile_screen/profile_view_controller.dart';
import 'package:fitness_99/core/api/api_service.dart';
import 'package:fitness_99/core/services/data_model.dart';
import 'package:fitness_99/core/services/user_model_service.dart';
import 'package:fitness_99/global/widgets/custom_snackbar.dart';
import 'package:fitness_99/models/updateProfilePicture/update_profile_picture_request.dart';
import 'package:fitness_99/models/updateProfilePicture/update_profile_picture_response.dart';
import 'package:fitness_99/models/updateProfileResponseRequest/update_profile_request.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_cropper/image_cropper.dart';

class EditProfileController extends GetxController {
  final apiService = Get.find<ApiService>();
  final userModel = Get.find<UserModelService>();
  final profileViewController = Get.find<ProfileViewController>();
  final nameTED = TextEditingController();
  final emailTED = TextEditingController();
  final numberTED = TextEditingController();
  var image = ''.obs;
  final nameErr = ''.obs;
  final emailErr = ''.obs;
  final numberErr = ''.obs;
  final numberTextInputFormatter = LengthLimitingTextInputFormatter(10);
  final apiCalling = false.obs;
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
      emailErr.value = 'Enter Email Address';
      return false;
    } else if (!GetUtils.isEmail(emailTED.value.text)) {
      emailErr.value = 'Enter valid Email Address';
      return false;
    } else {
      emailErr.value = '';
      return true;
    }
  }

  bool validateName() {
    if (nameTED.value.text.isEmpty) {
      nameErr.value = 'Enter Username';
      return false;
    } else {
      nameErr.value = '';
      return true;
    }
  }

  bool validateNumber() {
    if (numberTED.value.text.isEmpty) {
      numberErr.value = 'Enter Mobile Number';
      return false;
    } else if (!numberTED.value.text.isPhoneNumber) {
      numberErr.value = 'Enter valid Mobile Number';
      return false;
    } else if (!numberTED.value.text.startsWith(RegExp(r'[6-9]'))) {
      numberErr.value = 'Enter a valid Mobile Number';
      return false;
    } else {
      numberErr.value = '';
      return true;
    }
  }

  getImage(ImageSource source) async {
    final picker = ImagePicker();
    final file = await picker.pickImage(source: source);
    if (file != null) {
      // final img = File(file.path);
      String fileName = file.path.split('/').last;
      final cropImage = await ImageCropper().cropImage(
        sourcePath: file.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        maxHeight: 300,
        maxWidth: 300,
        androidUiSettings: AndroidUiSettings(hideBottomControls: true),
      );
      await uploadImageApi(cropImage!.path, fileName);
    }
  }

  void submit() async {
    validateEmail();
    validateName();
    validateNumber();
    if (validateEmail() && validateName() && validateNumber()) {
      apiCalling.value = true;
      await updateProfileApi(
        email: emailTED.value.text,
        mobileNumber: numberTED.value.text,
        profilePicture: userModel.getProfilePicture(),
        userName: nameTED.value.text,
      );
      Get.back();
      customSnackBar(
        title: 'Success!',
        message: 'Your Profile is successfully updated',
        isSuccess: true,
      );
    }
  }

  Future<void> uploadImageApi(String filePath, String filename) async {
    var uploadImage = await Dio.MultipartFile.fromFile(
      filePath,
      filename: filename,
      contentType: MediaType('image', 'jpg'),
    );
    req = UpdateProfilePictureRequest(
        userId: userModel.getid(), profilePicture: uploadImage);

    var formData = Dio.FormData.fromMap(req.toJson());

    try {
      apiCalling.value = true;
      final dio = Dio.Dio()
        ..interceptors.add(PrettyDioLogger(requestBody: true));
      final result = await dio.post(
        'https://dev.99fitnessfriends.com/api/profile_picture',
        data: formData,
      );
      final response = UpdateProfilePictureResponse.fromJson(result.data);
      if (response.message.toLowerCase() == 'success') {
        UserLocalDataModel userLocalDataModel = UserLocalDataModel(
          id: userModel.getid(),
          userName: userModel.getUserName(),
          email: userModel.getEmail(),
          mobileNumber: userModel.getMobileNumber(),
          numbesrOfGroups: userModel.getNoOfGroups(),
          profilePicture:
              response.result?.profilePicture ?? userModel.getProfilePicture(),
          pendingInvitation: userModel.getPendingInvitation(),
        );
        await Hive.box<UserLocalDataModel>('user_data')
            .put('data', userLocalDataModel);
        image.value = userModel.getProfilePicture();
        apiCalling.value = false;
        customSnackBar(
          title: 'Success!',
          message: 'Your profile picture is successfully updated',
          isSuccess: true,
        );
      } else {
        customSnackBar(
          title: 'Error!',
          message: 'Some error while updating profile picture please try again',
          isSuccess: false,
        );
      }
    } catch (e) {}
  }

  Future<void> updateProfileApi({
    required String email,
    required String mobileNumber,
    required String profilePicture,
    required String userName,
  }) async {
    try {
      print(mobileNumber);
      UpdateProfileRequest body = UpdateProfileRequest(
        id: userModel.getid(),
        email: email,
        phoneNumber: mobileNumber,
        profilePicture: profilePicture,
        userName: userName,
      );
      final res = await apiService.getUpdateProfileReponse(
        updateProfileRequest: body,
        userId: userModel.getid(),
      );

      if (res.message.toLowerCase() == 'success') {
        UserLocalDataModel userLocalDataModel = UserLocalDataModel(
          id: userModel.getid(),
          userName: res.result!.userName,
          email: res.result!.email,
          mobileNumber: res.result!.phoneNumber ?? 'N/A',
          numbesrOfGroups: res.result!.groupCount,
          profilePicture: res.result!.profilePicture,
          pendingInvitation: userModel.getPendingInvitation(),
        );
        await Hive.box<UserLocalDataModel>('user_data')
            .put('data', userLocalDataModel);
        profileViewController.userName.value = res.result!.userName;
        profileViewController.email.value = res.result!.email;
        profileViewController.mobileNumber.value =
            res.result!.phoneNumber ?? 'N/A';
        profileViewController.numbesrOfGroups.value = res.result!.groupCount;
        profileViewController.profilePicture.value = res.result!.profilePicture;
        profileViewController.pendingInvitation.value =
            userModel.getPendingInvitation();

        apiCalling.value = false;
      }
    } on Dio.DioError catch (e) {
      apiCalling.value = false;
      print(e);
    }
  }
  // Future pickImageFromGallery() async {
  //   try {
  //     var picker = ImagePicker();
  //     final file = await picker.pickImage(
  //       source: ImageSource.gallery,
  //     );

  //     final img = File(file?.path ?? '');
  //     print('crop1');
  //     final File croppedImg = _cropImage(img);
  //     print('crop2');

  //     String fileName = img.path.split('/').last;
  //     await uploadImageApi(croppedImg.path, fileName);
  //     print('crop3');

  //     // var uploadImage = await Dio.MultipartFile.fromFile(
  //     //   img.path,
  //     //   filename: fileName,
  //     //   contentType: MediaType('image', 'jpg'),
  //     // );
  //     // req = UpdateProfilePictureRequest(
  //     //     userId: userModel.getid(), profilePicture: uploadImage);

  //     // var formData = Dio.FormData.fromMap(req.toJson());

  //     // try {
  //     //   apiCalling.value = true;
  //     //   final dio = Dio.Dio()
  //     //     ..interceptors.add(PrettyDioLogger(requestBody: true));
  //     //   final result = await dio.post(
  //     //     'http://fitness.rithlaundry.com/api/user/profile_picture',
  //     //     data: formData,
  //     //   );
  //     //   final response = UpdateProfilePictureResponse.fromJson(result.data);
  //     //   if (response.message.toLowerCase() == 'success') {
  //     //     UserLocalDataModel UserLocalDataModel = UserLocalDataModel(
  //     //       id: userModel.getid(),
  //     //       userName: userModel.getUserName(),
  //     //       email: userModel.getEmail(),
  //     //       mobileNumber: userModel.getMobileNumber(),
  //     //       numbesrOfGroups: "0",
  //     //       profilePicture: response.result?.profilePicture ??
  //     //           userModel.getProfilePicture(),
  //     //     );
  //     //     await Hive.box<UserLocalDataModel>('user_data').put('data', UserLocalDataModel);
  //     //     image.value = userModel.getProfilePicture();
  //     //     apiCalling.value = false;
  //     //     customSnackBar(
  //     //       'Success!',
  //     //       'Your profile picture is successfully updated',
  //     //       'success',
  //     //     );
  //     //   } else {
  //     //     customSnackBar(
  //     //       'Error!',
  //     //       'Some error while updating profile picture please try again',
  //     //       false,
  //     //     );
  //     //   }
  //     // } catch (e) {}
  //   } catch (e) {
  //     print("The exception is $e");
  //   }
  // }

}
