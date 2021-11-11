import 'package:fitness_99/controllers/group_screen_controller/display_screen_controller.dart';
import 'package:fitness_99/controllers/search_screen/search_screen_controller.dart';
import 'package:fitness_99/core/api/api_service.dart';
import 'package:fitness_99/core/services/needed_utils.dart';
import 'package:fitness_99/core/services/user_model_service.dart';
import 'package:fitness_99/global/widgets/custom_snackbar.dart';
import 'package:fitness_99/models/createGroupResponseRequest/create_group_request.dart';
import 'package:fitness_99/models/createGroupResponseRequest/create_group_response.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:dio/dio.dart' as dio;
import 'package:http_parser/http_parser.dart';

class CreateGroupController extends GetxController {
  final isBusy = false.obs;
  final groupNameTED = TextEditingController();
  final goalTED = TextEditingController();
  final locationTED = TextEditingController();
  final maxMembersTED = TextEditingController();
  final commentsTED = TextEditingController();
  final groupNameErr = ''.obs;
  final goalErr = ''.obs;
  final locationErr = ''.obs;
  final maxMembersErr = ''.obs;
  final commentsErr = ''.obs;
  final image = ''.obs;
  final file_name = ''.obs;
  final userModel = Get.find<UserModelService>();
  final searchScreenController = Get.find<SearchScreenController>();
  final displayGrouController = Get.find<DisplayScreenController>();
  final apiService = Get.find<ApiService>();

  bool validateGroupName() {
    if (groupNameTED.text.isEmpty) {
      groupNameErr.value = 'Enter group name';
      return false;
    }
    groupNameErr.value = '';
    return true;
  }

  bool validateGoal() {
    if (goalTED.text.isEmpty) {
      goalErr.value = 'Enter goal';
      return false;
    }
    goalErr.value = '';
    return true;
  }

  bool validateLocation() {
    if (locationTED.text.isEmpty) {
      locationErr.value = 'Enter location';
      return false;
    }
    locationErr.value = '';
    return true;
  }

  bool validateMaxMembers() {
    if (maxMembersTED.text.isEmpty) {
      maxMembersErr.value = 'Enter number';
      return false;
    } else if (int.parse(maxMembersTED.text) > 25 ||
        int.parse(maxMembersTED.text) < 1) {
      maxMembersErr.value = 'Group members range must be between 1-25';
      return false;
    } else if (!maxMembersTED.text.isNum) {
      maxMembersErr.value = 'Enter a valid number';
      return false;
    }
    maxMembersErr.value = '';
    return true;
  }

  bool validateComments() {
    if (commentsTED.text.isEmpty) {
      commentsErr.value = 'Enter comments';
      return false;
    }
    commentsErr.value = '';
    return true;
  }

  bool validateUploadImage() {
    if (image.value == '') {
      Fluttertoast.showToast(
        msg: 'Select profile image',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      return false;
    }
    return true;
  }

  getImage(ImageSource source) async {
    final picker = ImagePicker();
    final file = await picker.pickImage(source: source);
    if (file != null) {
      String fileName = file.path.split('/').last;
      final cropImage = await ImageCropper.cropImage(
        sourcePath: file.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        maxHeight: 300,
        maxWidth: 300,
        androidUiSettings: AndroidUiSettings(hideBottomControls: true),
      );
      image.value = cropImage?.path ?? '';
      file_name.value = fileName;
    }
  }

  void createGroup() async {
    validateGroupName();
    validateGoal();
    validateLocation();
    validateMaxMembers();
    validateComments();
    validateUploadImage();

    if (validateGroupName() &&
        validateGoal() &&
        validateLocation() &&
        validateMaxMembers() &&
        validateComments() &&
        validateUploadImage()) {
      isBusy.value = true;
      await createGroupApi();
      isBusy.value = false;
    }
  }

  Future<void> createGroupApi(
      {groupName, goal, location, maxMembers, comments}) async {
    try {
      dio.MultipartFile uploadedImage = await dio.MultipartFile.fromFile(
        image.value,
        filename: file_name.value,
        contentType: MediaType('image', 'jpg'),
      );
      CreateGroupRequest body = CreateGroupRequest(
        groupName: groupNameTED.text,
        goal: goalTED.text,
        location: locationTED.text,
        maxGroupMembers: maxMembersTED.text,
        comments: commentsTED.text,
        group_image: uploadedImage,
      );
      var formData = dio.FormData.fromMap(body.toJson());
      final prettyDio = dio.Dio()
        ..interceptors.add(PrettyDioLogger(requestBody: true));
      final result = await prettyDio.post(
        'https://dev.99fitnessfriends.com/api/createGroup/${userModel.getid()}',
        data: formData,
      );
      final res = CreateGroupResponse.fromJson(result.data);
      if (res.status == 200) {
        await NeededVariables.firebaseInstance
            .collection('users')
            .doc(userModel.getid.toString())
            .collection(userModel.getEmail())
            .add({
          'groupName': groupNameTED.text,
          'goal': goalTED.text,
          'location': locationTED.text,
          'maxGroupMembers': maxMembersTED.text,
          'comments': commentsTED.text,
        });
        customSnackBar('Group Created', 'Created Group Sucessfully', true);
        displayGrouController.getGroupData();
        searchScreenController.getAllGroupData();
        Get.back();
      } else {
        customSnackBar('Error!', 'Please try again', false);
        Get.back();
      }
    } on dio.DioError catch (e) {
      print(e);
      customSnackBar('Error!', 'Please try again', false);
    }
  }
}
